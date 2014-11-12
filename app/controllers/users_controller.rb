class UsersController < ApplicationController
  def profile
    @user        = current_user
    @completions = @user.project_completions.includes(project: :skill)
  end
end
