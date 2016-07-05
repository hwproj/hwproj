module Markdown
  def markdown(text)
    options = 
    {
      hard_wrap: true,
      escape_html: true
    } 

    extensions = 
    {
      autolink: true,
      superscript: true,
      disable_indented_code_blocks: false,
      tables: true,
      fenced_code_blocks: true,
      highlight: true,
      no_intra_emphasis: true,
      strikethrough: true,
      space_after_headers: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)

    markdown.render(text).html_safe
  end
end