class VehicleMake < ApplicationRecord
  has_many :vehicle_models, dependent: :destroy
end
