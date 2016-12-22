module StatisticsHelper

def get_statistic_text(title, data_title, func, terms)
    content_tag :tr do
        concat (content_tag :td, title)
        concat (content_tag :td, "", class: "separator")
        concat (content_tag :td, data_title, align: 'center')
        terms.collect { |term|  concat content_tag(:td, func[term], align: 'center')}.join().html_safe
    end
end	

end