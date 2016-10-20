module Github
  def github_create_webhook(submission)
    submission ||= Submission.find(session[:submission])
    repo_full_name = submission.url.split("/")[3..4].join("/")

    client = Octokit::Client.new access_token: current_user.github_access_token
    hooks = client.hooks(repo_full_name)

    old_url = 'https://hwproj.herokuapp.com/github/payload'
    urls = hooks.map{|x| x.config.url} if hooks && hooks.any?

    if !hooks || hooks.empty? ||
        (!urls.include?("#{ENV["HOST"]}/github/payload") &&
            !urls.include?(old_url))
      client.create_hook(repo_full_name, 'web',
      {
        url: "#{ENV["HOST"]}/github/payload",
        secret: ENV["GITHUB_WEBHOOK_SECRET"],
        content_type: 'json'
      },
      {
        events: ['pull_request', 'pull_request_review_comment', 'issue_comment'],
        active: true
      })
    elsif urls && urls.include?(old_url)
      hooks.each do |h|
        if h.config.url == old_url
          client.edit_hook(repo_full_name, h.id, 'web',
          {
           url: "#{ENV["HOST"]}/github/payload",
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
  end
end
