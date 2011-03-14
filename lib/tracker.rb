class Tracker

  def self.track(site)
    if pageview = site.pageviews.first
      pageview.update_attributes!(:pageviews => pageview.pageviews + 1)
    else
      site.pageviews.create!
    end

  end

end
