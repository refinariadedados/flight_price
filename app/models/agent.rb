class Agent < ApplicationRecord
  validates :id_agent, uniqueness: {scope: [:name, :agent_type]}
end
