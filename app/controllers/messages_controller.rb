class MessagesController < ApplicationController

	def new
		@message = Message.new
	end

	def create
		@message = Message.create(messages_params)

		redirect_to controller: 'tasks', action: 'show', id: @message.task_id, chat: 'on'

	end

	private

	def messages_params
      params.require(:message).permit(:sender_name, :text, :task_id, :user_id)
    end


end
