class RenamePageviewsToMeasurements < ActiveRecord::Migration
  def change
    rename_table :pageviews, :measurements
  end
end
