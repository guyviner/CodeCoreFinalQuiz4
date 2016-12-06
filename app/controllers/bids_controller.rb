class BidsController < ApplicationController

  def create
    bid_params = params.require(:bid).permit(:amount)
    @bid = Bid.new bid_params
    @auction = Auction.find(params[:auction_id])
    @bid.auction = @auction
    @bid.user = current_user
    if @bid.save
        @auction.current_price = @bid.amount
        @auction.save
        redirect_to @auction, notice: "Bid submitted!"
    else
        flash[:alert] = "Bid not created"
                      redirect_to @auction
    end
  end


  def index
    @bids = current_user.bids
  end

end
