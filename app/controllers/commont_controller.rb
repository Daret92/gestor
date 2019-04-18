class CommontController < ApplicationController
  def gps
  	@gps = GpsSave.all()
  end
  def bitacora
  end
end
