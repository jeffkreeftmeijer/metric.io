require 'acceptance/acceptance_helper'

feature 'Measurements' do
  background do
    @site = Site.create!
    (0..24).to_a.each do |n|
      @site.measurements.create!(
        :hourstamp => Time.new(2011, 3, 14, n),
        :pageviews => n
      )
    end
    
    visit "/sites/#{@site.id}/measurements"
  end

  scenario "see the pageview count per hour" do
    (0..24).to_a.each do |n|
      within("div.measurement_#{1300057200 + (3600 * n)}") { page.should have_content n }
    end
  end

end
