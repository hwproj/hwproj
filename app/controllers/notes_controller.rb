class NotesController < ApplicationController

  def update
    @note = Note.find(params[:id])
    @note.update(notes_params)
    redirect_to task_path(@note.submission.task)
  end

  def destroy
    Note.find(params[:id]).destroy
    redirect_to :back
  end

  private

    def notes_params
      params.require(:note).permit(:fixed)
    end

end
