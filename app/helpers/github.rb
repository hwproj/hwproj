module Github
  def github_create_webhook(submission)
    submission ||= Submission.find(session[:submission])
    repo_full_name = submission.url.split("/")[3..4].join("/")

    client = Octokit::Client.new access_token: current_user.github_access_token
    hooks = client.hooks(repo_full_name)

    if !hooks || hooks.empty? || !hooks.map{|x| x.events}.any?{|e| e.include? "pull_request"}
      client.create_hook(repo_full_name, 'web',
      {
        url: "#{ENV["CURRENT_HOST"]}/github/payload",
        secret: ENV["GITHUB_WEBHOOK_SECRET"],
        content_type: 'json'
      },
      {
        events: ['pull_request', 'pull_request_review_comment', 'issue_comment'],
        active: true
      })
    end
  end
end