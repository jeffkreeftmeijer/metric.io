class MeasurementsController < ApplicationController

  def index
    @measurements = Measurement.all
  end

end