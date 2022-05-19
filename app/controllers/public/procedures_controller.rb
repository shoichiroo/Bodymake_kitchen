class Public::ProceduresController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_procedure, only: [:new]

  def new
    @procedures = Procedure.where(recipe_id: params[:recipe_id])
  end

  def create
    @procedure = Procedure.new(procedure_params)
    if @procedure.save
      redirect_to request.referer
    else
      @procedures = Procedure.where(recipe_id: params[:recipe_id])
      render :new
    end
  end

  def destroy
    procedure = Procedure.find(params[:id])
    procedure.destroy
    redirect_to request.referer
  end

  def index
    redirect_to new_recipe_procedure_path(params[:recipe_id])
  end


  private


  def procedure_params
    params.require(:procedure).permit(:description, :recipe_id)
  end

  def ensure_procedure
    @procedure = Procedure.new(recipe_id: params[:recipe_id])
    if @procedure.recipe.customer != current_customer
      redirect_to recipe_path(params[:recipe_id])
    end
  end
end
