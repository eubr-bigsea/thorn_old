class Api::CardGridsController < ApplicationController
  before_action :authenticate_user_from_token!
  before_action :set_card, only: [:show, :update]

  respond_to :json

  def update
    if @card_grid.update(card_grid_params)
      render json: @card_grid
    else
      render json: ErrorSerializer.serialize(@card_grid), status: :unprocessable_entity
    end
  end

  def show
    render json: @card_grid
  end

  private

  def set_card
    @card_grid = CardGrid.find(params[:id])
  end

  def card_grid_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params.to_unsafe_h)
  end
end
