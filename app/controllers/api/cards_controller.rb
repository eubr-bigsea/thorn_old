class Api::CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  respond_to :json

  def index
    render json: Card.all
  end

  def show
    render json: @card
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

end
