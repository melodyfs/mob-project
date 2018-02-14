class ConversationsController < ApplicationController
  # set auth user later
  before_action :get_mailbox
  before_action :get_conversation, except: [:index, :empty_trash]
  before_action :get_box, only: [:index]
  # Individual messages are grouped into conversations

  def show

  end

  def destroy
    @conversation.move_to_trash(current_user)
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
    conversation.receipts_for(current_user).update_all(deleted: true)
    end
  end

  def restore
    @conversation.untrash(current_user)
  end
# accepts a conversation to reply to, a message body, an optional subject...
# if conver moved to trash, it'll be restored by default
  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

# retrieve different
  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end
end
