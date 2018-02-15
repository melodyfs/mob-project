class MessagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:create], raise: false
  # this makes @chosen_recipient either contains a user record or a nil value.
  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end

  def create
    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation

  end
end
