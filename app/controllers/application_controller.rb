# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def set_project
    @project = Project.find(params[:project_id])
  end

  def project_owner?
    redirect_to root_path, alert: "You don't have access to that project." unless @project.owner == current_user
  end
end
