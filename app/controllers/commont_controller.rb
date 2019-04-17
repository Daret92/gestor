class CommontController < ApplicationController
  def gps
  	@gps = GpsSave.all()
  end
end
