# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def carga_csv(modelo, archivo, llaves)
  require 'csv'
  CSV.foreach(Rails.root.join('db', archivo), headers: true, encoding: 'UTF-8') do |row|
    objeto = modelo.find_or_initialize_by(row.to_h.select { |k, v| llaves.include? k })
    if objeto.new_record?
      objeto.assign_attributes(row.to_h)
      objeto.save
    end
  end
end
carga_csv Commune, 'communes.csv', %w[codigo]

def carga_csv_with_communes(modelo, archivo, llaves)
  require 'csv'
  CSV.foreach(Rails.root.join('db', archivo), headers: true, encoding: 'UTF-8') do |row|
    objeto = modelo.find_or_initialize_by(row.to_h.select { |k, v| llaves.include? k })
    if objeto.new_record?
      row_hashs = row.to_h
      communes = row_hashs["communes"]
      row_hashs.delete("communes")

      objeto.assign_attributes(row_hashs)
      objeto.communes << Commune.where(codigo: communes.split("/"))
      errores=objeto.save(validate: false)
      puts errores
    end
  end
end
LoadType.create([{id: 1, name: "General"},{id: 2, name: "Refrigerada"}])

carga_csv_with_communes Driver, 'drivers.csv', %w[id]
carga_csv Vehicle, 'vehicles.csv', %w[id]
carga_csv_with_communes Route, 'routes.csv', %w[id]




# Commune.all.each do |commune|
#   Route.all.each do |route|
#     if rand(0..1) == 1
#       route.communes << commune
#       route.save
#     end
#   end
#   Driver.all.each do |driver|
#     if rand(0..1) == 1
#       driver.communes << commune
#       driver.save
#     end
#   end
# end



