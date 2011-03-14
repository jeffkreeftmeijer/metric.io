class Tracker

  def self.track(site)
    measurement = site.measurements.first(
      :conditions => {:hourstamp => Time.now.change(:min => 0, :sec => 0)}
    )

    if measurement
      measurement.update_attributes!(:pageviews => measurement.pageviews + 1)
    else
      site.measurements.create!(:hourstamp => Time.now.change(:min => 0, :sec => 0))
    end

  end

end
