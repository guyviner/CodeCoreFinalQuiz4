class AddUserReferencesToBids < ActiveRecord::Migration[5.0]
  def change
    add_reference :bids, :user, index: true, foreign_key: true
  end
end
