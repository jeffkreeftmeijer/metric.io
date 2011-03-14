class AddPageviewsToPageviews < ActiveRecord::Migration
  def change
    add_column :pageviews, :pageviews, :integer, :default => 1
  end
end
