class Public::ProceduresController < ApplicationController
  before_action :authenticate_customer!

  def new
    @procedure = Procedure.new(recipe_id: params[:recipe_id])
    @procedures = Procedure.where(recipe_id: params[:recipe_id])
  end

  def create
    procedure = Procedure.new(procedure_params)
    procedure.save
    redirect_to request.referer
  end

  def destroy
    procedure = Procedure.find(params[:id])
    procedure.destroy
    redirect_to request.referer
  end

  def procedure_params
    params.require(:procedure).permit(:description, :recipe_id)
  end
end
