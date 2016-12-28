module StatisticsHelper

	def statistics_line(title, total, values)
  	content_tag :tr do
    	concat (content_tag :td, title)
    	concat (content_tag :td, "", class: 'separator')
    	concat (content_tag :td, total, align: 'center')
    	values.collect { |value|  concat content_tag(:td, value, align: 'center')}.join().html_safe
   	end
	end	

	def problem_with_max_or_min_attempts_line(title, array)
  	content_tag :tr do
    	concat (content_tag :td, title)
    	concat (content_tag :td, "", class: 'separator')
    	concat (content_tag :td, "", align: 'center')
    	((0..(array.length - 1)).map{ |i| concat content_tag(:td, array[i], align: 'center')}.join().html_safe())
  	end
	end
end
