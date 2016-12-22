module ErrorsHelper
  class Errors
    # Renders 403 error for passed controller
    def self.forbidden(controller)
      controller.render("public/403.html", status: 403, layout: false)
    end
  end
end