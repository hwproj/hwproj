class MessagesController < ApplicationController

	def new
		@message = Message.new
	end

	def create
		@message = Message.create(messages_params)

		redirect_to @message.task

	end

	private

	def messages_params
      params.require(:message).permit(:user, :text, :task_id, :number)
    end


end
