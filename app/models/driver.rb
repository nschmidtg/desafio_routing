class Driver < ApplicationRecord
    has_one :vehicle
    has_one :owned, :class_name => :Vehicle, :foreign_key => "owner_id"
    has_and_belongs_to_many :communes
    has_many :routes

    def valid_driver?
        return (self.valid_communes? && self.valid_max_stops? && self.valid_ownership? && self.valid_schedule?)
    end

    def valid_communes?
        self.routes.each do |route|
            return false if route.invalid_communes?
        end
        return true
    end

    def valid_max_stops?
        return self.routes.pluck(:stops_ammount).inject(0){|sum,x| sum + x } > self.max_stops ? false : true
    end

    def valid_ownership?
        if self.owned.present?
            return self.owned_id == self.vehicle_id ? true : false
        end
        return true
    end

    def valid_schedule?
        #TODO
        sorted_routes = self.routes.order(:starts_at)
        sorted_routes.each_with_index do |route,i|
            index=i+1
            if index < sorted_routes.count 
                nextu = sorted_routes[index]
                return false if route.ends_at > nextu.starts_at
            end
        end
        return true
    end
end
