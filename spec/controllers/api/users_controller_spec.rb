require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  before do
    sign_in create(:user)
  end
  let(:valid_attributes) { attributes_for(:user) }
end
