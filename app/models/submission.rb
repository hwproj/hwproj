class Submission < ActiveRecord::Base
	belongs_to :user
	belongs_to :task
	has_many :notes, dependent: :destroy

	mount_uploader :file, SubmissionUploader

	default_scope -> { order('created_at DESC') }
end
