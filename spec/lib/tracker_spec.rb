require 'spec_helper'
require 'tracker'

describe Tracker do

  describe "#track" do

    before do
      @site = Site.create!
    end

    it "creates a new measurement" do
      expect { Tracker.track(@site) }.to change(Measurement, :count).by(1)
    end

    it "fails to create a measurement without a site" do
      expect { Tracker.track }.to raise_error(ArgumentError)
    end

    context "when a measurement record for this site already exists" do

      before { @measurement = @site.measurements.create! }

      it "updates the existing measurement" do
        expect { Tracker.track(@site) }.not_to change(Measurement, :count)
        @measurement.reload.pageviews.should == 2
      end

    end

    describe "the returned measurement object" do

      before { @measurement = Tracker.track(@site) }

      it "has a site id" do
        @measurement.site.should == @site
      end

      it "has a pageview count of 1" do
        @measurement.pageviews.should == 1
      end

    end

  end

end
