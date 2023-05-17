class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }

  def index
    @users = User.all
    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def update
  @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(usuario_params)
        format.html { redirect_to @user }
        format.json { render json: @user, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
