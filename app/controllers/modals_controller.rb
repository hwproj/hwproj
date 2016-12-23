class ModalsController < ApplicationController
  def markdown_help_modal
    respond_to do |format|
      format.html
      format.js
    end
  end
end
