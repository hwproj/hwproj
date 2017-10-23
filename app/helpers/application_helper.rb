module ApplicationHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar img-rounded")
  end

  def sortable_link_to(direction, url_options = {}, title_options = {})
    css_class = direction == :desc ? 'glyphicon-sort-by-attributes-alt' : 'glyphicon-sort-by-attributes'
    title = title_options.fetch(direction, direction == :desc ? 'От новых к старым' : 'От старых к новым')
    direction = direction == :desc ? :asc : :desc

    link_to url_options.merge(direction: direction) do
      content_tag(:span, title) + content_tag(:span, nil, class: ['glyphicon', css_class])
    end
  end
end
