class UsersController < ApplicationController
  def profile
    @user        = current_user
    @completions = @user.project_completions.includes(project: :skill).order(updated_at: :desc)
  end

  def connect_stackoverflow
    current_user.connect_stackoverflow(request.env['omniauth.auth'])
    redirect_to root_url, notice: 'StackOverflow account connected!'
  end
end