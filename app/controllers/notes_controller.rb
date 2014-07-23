class NotesController < ApplicationController

  def update
    @note = Note.find(params[:id])
    @note.update(notes_params)
    redirect_to task_path(@note.submission.task)
  end

  private

    def notes_params
      params.require(:note).permit(:fixed)
    end

end
