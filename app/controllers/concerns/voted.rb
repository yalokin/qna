module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:vote_up, :vote_down]
  end

  def vote_up
    vote('up')
  end

  def vote_down
    vote('down')
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end

  def vote(direction)
    if @votable.vote(current_user, direction)
      success_respond
    else
      error_respond('Something went wrong')
    end
  end

  def success_respond
    json_respond(@votable.rating)
  end

  def json_respond(content, status = 200)
    render json: { id: @votable.id, content: content, controller: controller_name.singularize }, status: status
  end

  def error_respond(message)
    json_respond(message, 403)
  end
end