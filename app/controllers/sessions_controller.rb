class SessionsController < ApplicationController
  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to root_path, notice: "ログインしました"
    else
      flash.now[:alert] = "メールアドレスかパスワードが間違っています"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "ログアウトしました"
  end
end
