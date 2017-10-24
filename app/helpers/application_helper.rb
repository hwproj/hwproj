module ApplicationHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar img-rounded")
  end

  def dom_id(*args)
    args.map do |a|
      if a.respond_to?(:id)
        "#{dom_class(a)}_#{a.id}"
      elsif a.respond_to?(:to_sym)
        a.to_sym
      elsif a.respond_to?(:to_key)
        a.to_key
      else
        a.object_id
      end
    end.join('-')
  end

  def css_id(*args)
    "##{dom_id(*args)}"
  end
end
