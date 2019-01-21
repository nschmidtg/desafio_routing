class StaticController < ApplicationController
    def home
    end

    def clean_relationships!
        
        Route.all.each do |route|
            route.driver=nil
            route.vehicle=nil
            route.save(validate: false)
        end
        

    end

    def calculate
        #Cambiar fecha a evaluar rutas
        model_day = "24/01/2019".to_date
        start = Time.now
        @while_count=0
        routes = Route.where(starts_at: model_day.beginning_of_day..model_day.end_of_day)
        drivers = Driver.all 
        vehicles = Vehicle.all
        valid_assignment=false
        matrixes = Array.new
        if routes.count != 0 && vehicles.count != 0 && drivers.count != 0
            #Cambiar tiempo en segundos durante el cual se buscarán soluciones
            while ((Time.now.to_i - start.to_i) < 10)
                #Avoid heroku timeout
                @while_count+=1
                clean_relationships!
                matrix = Array.new()
                                
                total_cost=0
                routes.each do |route|
                    if rand(0..1) == 1
                        #This route is going to be in the possible solution
                        route=Route.find(route.id)
                        load_type_vehicles = vehicles.where(load_type_id: route.load_type_id)
                        vehicle=load_type_vehicles[rand(0..load_type_vehicles.count-1)]
                        route.vehicle = vehicle
                        driver=route.vehicle.owner.present? ? route.vehicle.owner : drivers[rand(0..drivers.count-1)]
                        
                        route.driver = driver
                        route.save

                        vehicle.driver=driver
                        vehicle.save

                        cost = route.get_cost
                        if cost.nil?
                            total_cost=nil
                            route.vehicle=nil
                            route.driver=nil
                            vehicle.driver=nil
                            vehicle.save
                            route.save
                            valid_assignment=false
                            break
                        else
                            if route.get_cost==0
                                binding.pry
                            end
                            begin
                            valid_assignment=true
                            matrix << [route.vehicle.id,route.driver.id,route.id,route.get_cost]
                            rescue
                                binding.pry
                            end 
                        end
                        total_cost+=cost
                    else
                        cost = route.get_cost
                        
                        matrix << [0,0,route.id,route.get_cost]
                        if cost.nil?
                            total_cost=nil
                            route.vehicle=nil
                            route.driver=nil
                            valid_assignment=false
                            route.save
                            break
                        end
                        total_cost+=cost
                    end
                    
                end
                if total_cost != nil
                    matrix << [total_cost,0,0,0]
                    matrixes << matrix
                end
            end
            min_cost=nil
            best_matrix_index = nil
            matrixes.each_with_index do |matrix,i|
                current_cost = matrix.last[0]
                if min_cost == nil
                min_cost = current_cost
                best_matrix_index = i
                elsif current_cost < min_cost
                min_cost = current_cost
                best_matrix_index = i
                end
            end
            #binding.pry
            @solution = matrixes[best_matrix_index]
            @valid_solutions = matrixes.count
            clean_relationships!
            
        end
    end
end
