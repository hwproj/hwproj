class Submission < ActiveRecord::Base
  include AddProtocol

  before_create :add_protocol

	belongs_to :student
	belongs_to :task
  	belongs_to :teacher, class_name: 'User'

	has_many :notes, dependent: :destroy

	mount_uploader :file, SubmissionUploader

	default_scope -> { order('created_at DESC') }

	accepts_nested_attributes_for :notes, :reject_if => :all_blank, :allow_destroy => true
end
