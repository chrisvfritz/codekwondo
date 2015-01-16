class UsersController < ApplicationController
  def profile
    authorize! :show_profile_for, current_user
    @user        = current_user
    @completions = @user.project_completions.includes(project: :skill).order(updated_at: :desc)
  end

  def connect_stackoverflow
    current_user.connect_stackoverflow(request.env['omniauth.auth'])
    redirect_to root_url, notice: 'StackOverflow account connected!'
  rescue OmniAuth::Strategies::StackExchange::NotRegisteredForStackExchangeSiteError
    redirect_to rool_url, alert: 'Your Stack Exchange account has never been used to log in to Stack Overflow. This must be done before connecting to Codekwondo.'
  end
end