class AuctionsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create]

  def new
    @auction = Auction.new
  end

  def create
    auction_params = params.require(:auction).permit(:title, :details, :end_date, :reserve_price)
    @auction = Auction.new(auction_params)
      @auction.user = current_user
      if @auction.save
        redirect_to @auction, notice: "Auction created!"
      else
        flash[:alert] = "Auction not created! Please see errors below."
        render :new
      end
  end

  def show
    @auction = Auction.find params[:id]
    @bid = Bid.new(auction: @auction)
    @bids = @auction.bids
    
  end

  def index
    @auctions = Auction.all
  end

end
