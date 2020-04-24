include TimeSeriesInitializer

class ProjectsController < ApplicationController
  load_resource only: [:show]

  def index
    latest_project = current_user.hours.last&.project
    latest_category = current_user.hours.last&.category

    @projects = Project.unarchived.by_last_updated.page(params[:page]).per(15)
    @hours_entry = Hour.new(is_client_billable: true, project: latest_project, category: latest_category)
    @mileages_entry = Mileage.new
    @activities = Hour.by_last_created_at.limit(30)
    @timer = current_user.timers.new(is_client_billable: true, project: latest_project, category: latest_category)
    @categories = Category.by_name
  end

  def show
    @time_series = time_series_for(@project)
    @hours_entries = @project.hours.by_date.page(params[:hours_pages]).per(20)

    respond_to do |format|
      format.html{}
      format.json do
        render json: @project
      end
    end
  end

  def edit
    resource
    @project.rates.build if @project.rates.empty?
  end

  def new
    @project = Project.new(billable: true)
    User.find_each do |user|
      @project.rates.build(user: user, amount: user.base_amount)
    end
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to root_path, notice: t(:project_created)
    else
      render action: "new"
    end
  end

  def update
    if resource.update_attributes(project_params)
      redirect_to project_path(resource), notice: t(:project_updated)
    else
      render action: "edit"
    end
  end

  def selected
      @project = Project.find(params[:id])
      
      respond_to do |format|
          format.js
      end
  end

  private

  def entry_type
    request.fullpath == mileage_entry_path ? "mileages" : "hours"
  end

  def resource
    @project ||= Project.find_by_slug(params[:id])
  end

  def project_params
    params.require(:project).
      permit(:name, :billable, :client_id, :archived, :description, :budget, :use_dollars, rates_attributes: [:id, :user_id, :project_id, :amount, :_destroy])
  end
end
