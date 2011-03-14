class AddHourstampToMeasurements < ActiveRecord::Migration
  def change
    add_column :measurements, :hourstamp, :datetime
  end
end
