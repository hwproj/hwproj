class AddPullRequestToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :pull_request, :boolean, default: false
  end
end
