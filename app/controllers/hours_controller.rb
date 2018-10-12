class HoursController < EntriesController
  def create
    @entry = Hour.new(entry_params)
    @entry.user = current_user

    respond_to do |format|
      if @entry.save
        format.html {
          redirect_to root_path, notice: t("entry_created.hours")
        }
        format.js {
          flash[:notice] = t("entry_created.hours")
          render js: "window.location='#{root_path}'"
        }
        format.json {
          render json: @entry, status: :created, location: root_path
        }
      else
        format.html {
          redirect_to root_path, notice: @entry.errors.full_messages.join(". ")
        }
        format.js {
          flash[:notice] = @entry.errors.full_messages.join(". ")
          render js: "window.location='#{root_path}'"
        }
        format.json {
          render json: @entry.errors, status: :unprocessable_entity
        }
      end
    end
  end

  def update
    if resource.update_attributes(entry_params)
      redirect_to user_entries_path(current_user), notice: t("entry_saved")
    else
      redirect_to edit_hour_path(resource), notice: t("entry_failed")
    end
  end

  def edit
    super
    resource
  end

  private

  def resource
    @hours_entry ||= current_user.hours.find(params[:id])
  end

  def entry_params
    params.require(:hour).
      permit(:project_id, :user_id, :category_id, :value, :description, :date).
      merge(date: parsed_date(:hour))
  end
end
