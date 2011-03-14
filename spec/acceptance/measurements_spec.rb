require 'acceptance/acceptance_helper'

feature 'Measurements' do
  background do
    @site = Site.create!
    (0..24).to_a.each do |hour|
      @site.measurements.create!(:hourstamp => hour, :pageviews => hour)
    end
    
    visit "/sites/#{@site.id}/measurements"
  end

  scenario "view today's measurements" do
    (0..24).to_a.each do |hour|
      within("div.measurement_#{hour}") { page.should have_content hour }
    end
  end

end
