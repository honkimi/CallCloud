class SheetsController < ApplicationController
  before_action :authenticate_user!

  def show
    @tel = Tel.find(params[:tel_id]) 
    render json: @tel.sheet || {actions: []}
  end

  def update
    @tel = Tel.find(params[:tel_id])
    @tel.sheet = sheet_param[:sheet]
    @tel.first_msg = sheet_param[:first_msg]
    res = {}
    if @tel.save
      res['status'] = "ok"
    else
      res['status'] = "ng"
    end
    render json: res
  end

  private
  def sheet_param
    params.permit(:sheet, :first_msg)
  end
end
