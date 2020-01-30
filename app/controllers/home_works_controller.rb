class HomeWorksController < ApplicationController
  before_action :set_home_work, only: [:show, :edit, :update, :destroy]

  # GET /home_works
  # GET /home_works.json
  def index
    @home_works = HomeWork.all
  end

  # GET /home_works/1
  # GET /home_works/1.json
  def show
  end

  # GET /home_works/new
  def new
    @home_work = HomeWork.new
  end

  # GET /home_works/1/edit
  def edit
  end

  # POST /home_works
  # POST /home_works.json
  def create
    @home_work = HomeWork.new(home_work_params)
    @home_work.user2_id = current_user.id
    @home_work.finalizado = false
    respond_to do |format|
      if @home_work.save
        format.html { redirect_to @home_work, notice: 'Home work was successfully created.' }
        format.json { render :show, status: :created, location: @home_work }
      else
        raise
        format.html { render :new }
        format.json { render json: @home_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /home_works/1
  # PATCH/PUT /home_works/1.json
  def update
    respond_to do |format|
      if @home_work.update(home_work_params)
        format.html { redirect_to @home_work, notice: 'Home work was successfully updated.' }
        format.json { render :show, status: :ok, location: @home_work }
      else
        format.html { render :edit }
        format.json { render json: @home_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /home_works/1
  # DELETE /home_works/1.json
  def destroy
    @home_work.destroy
    respond_to do |format|
      format.html { redirect_to home_works_url, notice: 'Home work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home_work
      @home_work = HomeWork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_work_params
      params.require(:home_work).permit(:proyecto_id, :user_id, :descripcion, :urgente, :limite,:finalizado,:resultado)
    end
end
