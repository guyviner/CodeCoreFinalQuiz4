require 'rails_helper'

RSpec.describe BidsController, type: :controller do

  let(:auction) {FactoryGirl.create(:auction) }
  let(:bid)     {FactoryGirl.create(:bid, {auction: auction}) }
  let(:user)     {FactoryGirl.create(:user)}

  before { login(user) }

  describe "#create" do
    context "with valid attributes" do
            def valid_request
              post :create, auction_id: auction.id, bid: {amount: 100}
            end

            it "creates a record in the database" do
              expect{valid_request}.to change{Bid.count}.by(1)
            end
          end
          context "with invalid attributes" do

            def invalid_request
              post :create, auction_id: auction.id, bid: {amount: nil}
            end

            it "renders the auction show page " do
              invalid_request
              expect(response).to redirect_to(auction_path(auction))
            end
          end
        end
      end
