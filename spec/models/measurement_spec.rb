require 'spec_helper'

describe Measurement do
  before do
    Measurement.without_callback(:save, :after, :push_changes) do
      @measurement = Measurement.create!(:site_id => 123)
    end
  end

  describe "#after_save" do

    it "calls #push_changes" do
      @measurement.expects(:push_changes)
      @measurement.save!
    end

  end

  describe "#push_changes" do

    it "pushes the update" do
      Pusher['site-123'].expects(:trigger).with('measurement-saved', @measurement.attributes)
      @measurement.push_changes
    end

  end

end