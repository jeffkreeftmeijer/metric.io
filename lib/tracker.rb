class Tracker

  def self.track(site)
    site.pageviews.create!
  end

end
