class LinkUserPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :owner, foreign_key: { to_table: :users }
  end
end
