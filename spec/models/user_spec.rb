require 'rails_helper'

RSpec.describe User, type: :model do
  context "Relations" do
    it { should have_many(:jobs) }
    it { should have_many(:workflows) }
  end

  context "Validations" do
    %i{first_name last_name email password password_confirmation }.each do |field|
      it { should validate_presence_of(field) }
    end
  end

  context "Fixtures" do
    it { expect(create(:user)).to be_valid }

    it "doesn't allow invalid email" do
      expect(build(:user, email: "email@fcom")).to be_invalid
    end
  end

  context "Scope" do
   it "it is saved with authentication_token = nil" do
     user = build(:user)
     expect(user.authentication_token).to be_nil
     user.save()
     expect(user.authentication_token).to_not be_nil
   end

  end



end
