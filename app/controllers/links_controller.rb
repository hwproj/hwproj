class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
  end

  def create
    Link.create(links_params)
    redirect_to links_path
  end

  private
    def links_params
      params.require(:link).permit(:name, :url)
    end
end