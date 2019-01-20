class Route < ApplicationRecord
    belongs_to :load_type
    has_and_belongs_to_many :communes
    belongs_to :driver
    belongs_to :vehicle

    def get_cost
        #Calculates the cost of the current valid asociation or nil if it is not valid
        #1) The current route has not been assigned
        return self.load_sum * self.storage_cost_per_load + self.unsatisfied_cost if (self.vehicle.blank? || self.driver.blank?)
        #2) The current route has been assigned to a valid vehicle and driver
        return self.vehicle.get_cost if (self.valid_vehicle? && self.valid_driver?)
        #3) The current route has been assigned to a invalid vehicle or invalid driver
        return nil
    end

    def valid_vehicle?
        return false if self.vehicle.nil?
        #There is a vehicle assigned
        return self.vehicle.valid_vehicle?
        #Check vehicle intrinsic restrictions

    end 

    def valid_driver?
        return false if self.driver.nil?
        #There is a driver assigned
        return self.driver.valid_driver?
        #Check driver intrinsic restrictions
    end 

    def invalid_communes?
        self.communes.each do |commune|
            return true if !commune.drivers.pluck(:id).include? self.driver_id
        end
        return false
    end
end
