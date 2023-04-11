class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(usuario_params)
    redirect_to @user, notice: 'Perfil actualizado exitosamente.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def usuario_params
    params.require(:user).permit(:full_name, :image, :bio)
    end
end
