class AddHourstampToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :hourstamp, :time
  end
end
