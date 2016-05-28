class Award < ActiveRecord::Base
  belongs_to :job

  before_destroy :update_awards

  private
    def update_awards
      current_rank = self.rank
      jobs = self.job.assignment.jobs.where(done: true).order(updated_at: :asc)
      jobs.each do |job|
        if job.awards.first
          if job.awards.first.rank > current_rank
            job.awards.first.update(rank: job.awards.first.rank - 1)
          end
        elsif job.assignment.awards.count == 3
          job.awards.create(rank: 3)
        end
      end
    end

end
