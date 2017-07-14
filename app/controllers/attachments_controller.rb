class AttachmentsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def destroy
    @attachment = Attachment.find(params[:id])
    if current_user.author_of?(@attachment.attachable)
      @attachment.destroy
      flash[:notice] = 'Attachment successfully deleted'
    else
      flash[:notice] = 'You can not to delete this attachment'
    end
  end
end
