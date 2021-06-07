class LinkUserPost < ActiveRecord::Migration[6.1]
  def change
    add_belongs_to :posts, :owner, foreign_key: true
  end
end
