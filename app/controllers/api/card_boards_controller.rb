class Api::CardBoardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @cards = Card.all
    @cards.each do |card|
      card.title = t(card.title)
      if(card.content != "")
        card.content = t(card.content)
      end
    end
    render json: @cards
  end

  def create
    newCard = Card.new(card_params)
    if newCard.save
      render json: newCard
    else
      render json: ErrorSerializer.serialize(newCard.errors), status: :unprocessable_entity
    end
  end

  def show
    render json: @card_board
  end

  def destroy
    user = User.first
    user.cards.destroy(params[:id])
  end

  private

  def set_card
    @card_board = CardBoard.find(params[:id])
  end

  def card_board_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end

end
