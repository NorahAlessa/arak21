class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /appointments
  # GET /appointments.json
  def index
    if user_signed_in?
    if current_user.admin == true
    @appointments = Appointment.all.order('appointment_on ASC')
    else
    @appointments = current_user.appointments.order('appointment_on ASC')
    end
  end
  end

def byDoctor
  # if user_signed_in?
  #   if current_user.admin == true
  @doctor = Doctor.find_by(name: params[:doctor] )
  @appointments = Appointment.where({doctor_id: @doctor.id }).order('appointment_on ASC')
#     else

#     end
#   end
 end
  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    # (params[:appointment])
    
    @appointment = Appointment.new(appointment_params)
    if !params[:appointment]["appointment_on(1i)"] == "اختر السنه"
    @appointment.appointment_on =  DateTime.new( 
    params[:appointment]["appointment_on(1i)"].to_i,
    params[:appointment]["appointment_on(2i)"].to_i,
    params[:appointment]["appointment_on(3i)"].to_i,
    params[:appointment]["appointment_on(4i)"].to_i)
    else
      @appointment.appointment_on =  DateTime.current( )
    end
   
    # params[:appointment]["appointment_on(5i)"].to_i
    # @appointment.appointment_on = params[:appointment]
    # new DateTime(data.Year, data.Month, data.Day, data.Hour, data.Minute, 59, 999);
    # @appointment.appointment_on = new_datetime_data_var from params[:appointment]
    
    # render plain: params[:appointment]  

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def appointment_params
      params.require(:appointment).permit(:doctor_id, :user_id)
    end
end
