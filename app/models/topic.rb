class Topic < ApplicationRecord
  attr_accessor :csv_file
  has_many :items, dependent: :destroy
  belongs_to :user

  def random_item
    self.items.sample
  end
end
