class Lap < ApplicationRecord
  belongs_to :vehicle
  belongs_to :track
end
