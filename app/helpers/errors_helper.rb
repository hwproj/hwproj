module ErrorsHelper
  class Errors
    def self.forbidden(controller)
      controller.render("public/403.html", status: 403, layout: false)
    end
  end
end