class Post < ApplicationRecord
  belongs_to :owner, class_name: "User"

  validates :title, presence: true, length: { in: 10..100}
  validates :content, presence: true, length: { in: 50..1000}
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0}

end
