class CommontController < ApplicationController
  def gps
  	@gps = GpsSave.all()
  end
  def bitacora
  end
  def asistencia
  	if params.has_key?('fecha')
  		@asistencias = Assistance.where(updated_at:DateTime.strptime(params[:fecha],"%m/%d/%Y").all_day)
  		@fecha = params[:fecha]
  	else
  		@asistencias =Assistance.all().order('id DESC')
  	end
  end
end
