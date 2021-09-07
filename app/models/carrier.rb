class Carrier < ApplicationRecord
  validates :carrier_id, uniqueness: {scope: [:name, :code]}
end
