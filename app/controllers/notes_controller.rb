class NotesController < ApplicationController
  before_action :set_note, only: [ :update, :destroy ]

  def update
    @note.update(notes_params)
    redirect_to task_path(@note.submission.task)
  end

  def destroy
    @note.destroy
    redirect_to :back
  end

  private
    def notes_params
      params.require(:note).permit(:fixed)
    end

    def set_note
      @note = Note.find(params[:id])      
    end
end
