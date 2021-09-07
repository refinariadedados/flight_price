class Place < ApplicationRecord
  validates :place_id, uniqueness: {scope: [:name, :place_type, :code]}
end
