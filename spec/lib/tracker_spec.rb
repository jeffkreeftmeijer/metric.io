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

      context "and it's created in the same hour" do

        before do
          Timecop.freeze(Time.local(2011, 3, 14, 16, 53, 14))
          @measurement = @site.measurements.create!(
            :hourstamp => Time.local(2011, 3, 14, 16, 0, 0)
          )
        end

        after { Timecop.return }

        it "updates the existing measurement" do
          expect { Tracker.track(@site) }.not_to change(Measurement, :count)
          @measurement.reload.pageviews.should == 2
        end

      end

      context "but it was created a week ago" do

        before do
          Timecop.travel(1.week.ago) do
            @measurement = @site.measurements.create!
          end
        end

        it "creates a new measurement" do
          expect { Tracker.track(@site) }.to change(Measurement, :count).by(1)
        end

        it "does not update the existing measurement" do
          Tracker.track(@site)
          @measurement.reload.pageviews.should == 1
        end

      end

    end

    describe "the returned measurement object" do

      before do
        Timecop.freeze(Time.local(2011, 3, 14, 16, 53, 14)) do
          @measurement = Tracker.track(@site)
        end
      end

      it "has a site id" do
        @measurement.site.should == @site
      end

      it "has a pageview count of 1" do
        @measurement.pageviews.should == 1
      end

      it "has an hourstamp" do
        @measurement.hourstamp.should == Time.local(2011, 3, 14, 16, 0, 0)
      end

    end

  end

end
