class AddTermsIndexOnCourseId < ActiveRecord::Migration
  def change
  	add_index :terms, :course_id
  end
end
