class CommontController < ApplicationController
  def gps
  	@gps = GpsSave.all()
  end
  def bitacora
  end
  def asistencia
  	@asistencias = Assistance.all()
  end
end
