class UserSessionsController < ApplicationController
  
  title "Logowanie"
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Zalogowano poprawnie w serwisie"
      redirect_back_or_default
    else
      flash[:error] = "Nieprawidłowy login lub hasło"
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find(params[:id])
    @user_session.destroy
    flash[:notice] = "Successfully destroyed user session."
    redirect_to root_url
  end
end
