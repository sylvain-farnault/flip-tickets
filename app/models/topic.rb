class Topic < ApplicationRecord
  attr_accessor :csv_file
  has_many :items, dependent: :destroy

  def random_item
    self.items.sample
  end
end
