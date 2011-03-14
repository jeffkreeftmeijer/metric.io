require 'spec_helper'
require 'tracker'

describe Tracker do

  describe "#track" do

    before do
      @site = Site.create!
    end

    it "creates a new pageview" do
      expect { Tracker.track(@site) }.to change(Pageview, :count).by(1)
    end

    it "fails to create a pageview without a site" do
      expect { Tracker.track }.to raise_error(ArgumentError)
    end

    context "when a Pageview record for this site already exists" do

      before { @pageview = @site.pageviews.create! }

      it "updates the existing Pageview" do
        expect { Tracker.track(@site) }.not_to change(Pageview, :count)
        @pageview.reload.pageviews.should == 2
      end

    end

    describe "the returned Pageview object" do

      before { @pageview = Tracker.track(@site) }

      it "has a site id" do
        @pageview.site.should == @site
      end

      it "has a pageview count of 1" do
        @pageview.pageviews.should == 1
      end

    end

  end

end
