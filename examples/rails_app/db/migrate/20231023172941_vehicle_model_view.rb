class VehicleModelView < ActiveRecord::Migration[7.1]
  def change
    # USE OUTER JOIN
    sql = <<~SQL
      CREATE VIEW vehicle_model_view AS
      SELECT vehicle_models.*, vehicle_makes.name AS vehicle_make_name
      FROM vehicle_models
      LEFT OUTER JOIN vehicle_makes ON vehicle_makes.id = vehicle_models.vehicle_make_id
    SQL
    execute sql
  end
end
