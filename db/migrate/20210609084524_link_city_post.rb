class LinkCityPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :city, foreign_key: { to_table: :cities }
  end
end 
