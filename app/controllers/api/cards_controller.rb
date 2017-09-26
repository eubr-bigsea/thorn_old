class Api::CardsController < ApplicationController
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
    @card.title = t(@card.title)
    if(@card.content != "")
      @card.content = t(@card.content)
    end

    render json: @card
  end

  def destroy
    user = User.first
    user.cards.destroy(params[:id])
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end

end
