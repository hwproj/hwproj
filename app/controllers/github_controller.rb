class GithubController < ApplicationController
  skip_before_action :protect_from_forgery
  protect_from_forgery with: :null_session

  def callback
    raise ActionController::RoutingError.new('Not Found') unless signed_in?

    session_code = params['code']

    result = RestClient.post('https://github.com/login/oauth/access_token',
                            {:client_id => ENV["GITHUB_CLIENT_ID"],
                             :client_secret => ENV["GITHUB_CLIENT_SECRET"],
                             :code => session_code},
                             :accept => :json)

    current_user.update! github_access_token: JSON.parse(result)['access_token']

    @submission = Submission.find(session[:submission])
    github_create_webhook(@submission)

    redirect_to task_path(@submission.task_id)
  end

  def payload
    # Security check
    request.body.rewind
    payload_body = request.body.read
    verify_signature(payload_body)

    # Respond to event
    action = (JSON.parse request.body.read)['action']
    case request.headers['X-GitHub-Event']
    when "pull_request"
      pull_request_event(params['pull_request']) if action == 'closed'

    when "issue_comment"
      issue_comment_event(params['issue'], params['comment']) if action == 'created'

    when "pull_request_review_comment"
      diff_comment_event(params['pull_request']) if action == 'created'
    end

    render nothing: true
  end

  private
    def verify_signature(payload_body)
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['GITHUB_WEBHOOK_SECRET'], payload_body)
      return halt 500, "Signatures didn't match!" unless Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end

    def pull_request_event(pull_request)
      if pull_request['merged']
        submission = get_submission(pull_request)
        submission.task.accepted!
      end
    end

    def issue_comment_event(issue, comment)
      submission = get_submission(issue)
      submission.notes.create(text: comment['body'])
      task = submission.task
      task.accepted_partially unless task.accepted?
    end

    def diff_comment_event(pull_request)
      submission = get_submission(pull_request)
      comments = JSON.parse(RestClient.get pull_request['review_comments_url'])
      submission.update comments_count: comments.count
    end

    def get_submission(pull_request)
      submission = Submission.where(url: pull_request['html_url']).first
    end
end
