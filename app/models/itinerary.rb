class Itinerary < ApplicationRecord
  validates :outbound_leg_id, uniqueness: {scope: [:inbound_leg_ig, :price, :agent]}
end
