class MessagesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_message
  # this makes @chosen_recipient either contains a user record or a nil value.
  # def new
  #   @chosen_recipient = User.find_by(id: params[:user])
  # end
  #
  # def create
    # @recipients = User.where(id: params['recipients'])
    # # @ecipient = User.find_by(id: params[:user])
    # conversation = current_user.send_message(@recipients, params[:body], params[:subject]).conversation
    # flash[:success] = "Message has been sent!"
    # redirect_to conversation_path(conversation)
    # @user = User.find_by(id: params[:user])

    # current_user.send_message(@recipient, params[:body], params[:subject])
  #   recipients = User.where(id: params['recipients'])
  #   conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
  #   flash[:success] = "Message has been sent!"
  #   redirect_to conversation_path(conversation)
  # end
    def new
        @user = User.find_by(id: params[:to].to_i) if params[:to]
        @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
    end

    def create
        recipient = User.find(id: params[:to].to_i) if params[:to]
        current_user.send_message(recipient, params[:body])
        flash[:success] = "Message has been sent!"
        redirect_to conversations_path
    end

    private

    def set_message
        @recipient = User.find(params[:receiver_id])
    end

    def message_params
        # params.require(:message).permit(:body)
        params.permit(:title, :body)
    end

end
