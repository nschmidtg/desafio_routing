class LoadType < ApplicationRecord
    has_many :vehicles
    has_many :routes
end
