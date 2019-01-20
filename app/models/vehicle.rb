class Vehicle < ApplicationRecord
    belongs_to :driver, :foreign_key => "driver_id", optional: true
    belongs_to :owner, :class_name => :Driver, :foreign_key => "owner_id", optional: true
    belongs_to :load_type
    has_many :routes

    def get_cost
        return Route.where(vehicle_id: self.id).map{|x|x.communes}.flatten.uniq.count*self.usage_cost_per_commune
    end

    def valid_vehicle?
        return true if (self.valid_capacity? && self.valid_load_type? && self.valid_driver?)
        return false
    end

    def valid_capacity?
        return self.routes.pluck(:load_sum).inject(0){|sum,x| sum + x } > self.capacity ? false : true
    end

    def valid_load_type?
        #If all the assigned routes to a vehicle, filtered by load_type are the same ammount of the original set, means that no one was removed
        return self.routes.where(load_type_id: self.load_type.id).count == self.routes.count ? true : false
    end
    
    def valid_driver?
        if self.owner.present?
            return self.owner_id == self.driver_id ? true : false
        end
        return true
    end
end
