module StatisticsHelper
  def statistics_line(title, values, total = '')
    content_tag :tr do
      concat (content_tag :td, title)
      concat (content_tag :td, "", class: 'separator')
      concat (content_tag :td, total, align: 'center')
      values.collect { |value|  concat content_tag(:td, value, align: 'center')}.join().html_safe
    end
  end 
end
