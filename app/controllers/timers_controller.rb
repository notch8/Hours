class TimersController < ApplicationController
  def index
    active_timer = current_user.active_timer
    if active_timer
      redirect_to edit_timer_path(active_timer)
    else
      redirect_to new_timer_path
    end
  end

  def new
    latest_project = current_user.hours.last&.project
    latest_category = current_user.hours.last&.category
    @timer = current_user.timers.new(is_client_billable: true, project: latest_project, category: latest_category)
    form_setup
  end

  def create
    @timer = current_user.timers.create(timer_params.merge({starts_at: Time.now}))
    if @timer.valid?
      redirect_to edit_timer_path(@timer)
    else
      form_setup
      flash.now[:notice] = "Could not start timer.  Please try again"
      render action: :new
    end
  end

  def edit
    form_setup
    @timer = current_user.timers.find params[:id]
  end

  def update
    @timer = current_user.timers.find params[:id]
    @timer.update_attributes(timer_params)

    if @timer.valid? && @timer.ends_at
      flash[:notice] = "Timer Completed"
      redirect_to user_entries_path(current_user)
    else
      flash.now[:notice] = "Could not update timer." unless @timer.valid?
      flash.now[:notice] = "Timer updated." if @timer.valid?
      form_setup
      render action: :edit
    end
  end

  def delete
    @timer = current_user.timers.find params[:id]
    if @timer
      flash[:noticde] = "Timer Cleared"
      @timer.destroy 
    end
  end

  private
  def timer_params
    params.require(:timer).permit(:project_id, :category_id, :description, :starts_at, :ends_at, :is_client_billable)
  end

  def form_setup
    @projects = Project.unarchived.by_name
    @categories = Category.by_name
  end
end
