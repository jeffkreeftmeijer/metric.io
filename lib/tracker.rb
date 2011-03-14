class Tracker

  def self.track(site)
    if measurement = site.measurements.first
      measurement.update_attributes!(:pageviews => measurement.pageviews + 1)
    else
      site.measurements.create!
    end

  end

end
