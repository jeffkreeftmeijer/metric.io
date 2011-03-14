require 'spec_helper'
require 'tracker'

describe Tracker do

  describe "#track" do    
    
    before do
      @site = Site.create!
    end
     
    it "stores the tracked pageview" do
      expect { Tracker.track(@site) }.to change(Pageview, :count).by(1)
    end
    
    it "fails to create a pageview without a site" do
      expect { Tracker.track }.to raise_error(ArgumentError)
    end
    
    context "the returned Pageview object" do
      
      before { @pageview = Tracker.track(@site) }

      it "has a site id" do
        @pageview.site.should == @site
      end
      
    end
        
  end
  
end
