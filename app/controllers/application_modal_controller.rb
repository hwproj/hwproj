class ApplicationModalController < ApplicationController

  # This method should be called for modals
  def prepare_to_respond(*args)
    @rmw = true

    @width = " modal-lg" if args.include? :thick
    @width ||= " modal-sm" if args.include? :thin
    @width ||= ""
  end

  def render(*args)
    @rmw ||= false
    options = args.extract_options!
    options.merge! layout: 'modal' if @rmw && request.xhr?
    puts "Args: ", args
    puts "Options: ", options
    super *args, options
  end

  def respond_to(options)
    @rmw ||= false
    if @rmw && request.xhr?
      head :ok, location: super.url_for(options)
    else
      super options
    end
  end
end
