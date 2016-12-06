require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:user) {FactoryGirl.create(:user) }
    before {login(user)}

    describe "new" do
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "makes a new auction that = @auction" do
        get :new
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end

    describe "create" do

      context "with valid attributes" do
          def valid_request
            post :create, auction: FactoryGirl.attributes_for(:auction)
          end
          it "creates a record in the database" do
          expect{valid_request}.to change{Auction.count}.by(1)
        end
      end

      context "with invalid attributes" do

          def invalid_request
            post :create, auction: {title: nil}
          end
          it "renders the new template" do
            invalid_request
            expect(response).to render_template(:new)
          end

      end
    end
end
