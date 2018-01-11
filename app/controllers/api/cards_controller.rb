class Api::CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  respond_to :json

  def index
    @cards = Card.all
    @cards.each do |card|
      aux = eval_card(card)
      aux.each do |key, value|
        card[key] = value
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
    aux = eval_card(@card)
    aux.each do |key, value|
      @card[key] = value
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

  def eval_card card
    json = JSON.parse(card.to_json)
    return eval_object(json)
  end

  def eval_object(json)
    json.each do |key, value|
      if value.class == String
        begin
          json[key] = eval(value)
        rescue SyntaxError
          json[key] = value
        rescue NameError
          json[key] = value
        end
      elsif value.class == Hash
        eval_object(value)
      end
    end
    return json
  end

end
