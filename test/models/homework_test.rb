require 'test_helper'

class HomeworkTest < ActiveSupport::TestCase
  test 'Homework should have a term' do
    h = Homework.new(assignment_type: :homework)
    assert_not h.save
  end
  test 'Homework should have an assignment type' do
    h = Homework.new(term_id: 3)
    assert_not h.save
  end
end
