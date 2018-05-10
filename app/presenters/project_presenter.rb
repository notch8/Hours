class ProjectPresenter
  NUMBER_OF_ACTIVITIES = 4
  attr_reader :template
  def initialize(project, template)
    @project = project
    @template = template
  end

  def show_categories
    template.render partial: "projects/category",
                    collection: categories_with_remainder,
                    locals: { project: @project }
  end

  def show_categories_bar
    template.render partial: "projects/categories_bar",
                    as: :category,
                    collection: categories_with_remainder,
                    locals: { project: @project }
  end

  def show_budget
    template.render partial: "projects/budget",
                    as: :project,
                    locals: { project: @project, percent_used: percent_used, background_color: background_color }
  end

  def show_budget_bar
    template.render partial: "projects/budget_bar",
                    as: :project,
                    locals: { project: @project, percent_used: percent_used, background_color: background_color }
  end

  private

  def sorted_categories
    @project.sorted_categories
  end

  def percent_used
    return 0 if @project.budget.blank? || @project.budget.zero?
    (amount_used.to_f / @project.budget.to_f * 100).round
  end

  def amount_used
    return 0 if @project.budget.blank?
    @project.budget - @project.dollar_budget_status
  end

  def background_color
    percent_used < 80 ? "#428bca" : "#d9534f"
  end

  def categories_with_remainder
    categories = sorted_categories
    if sorted_categories.length > NUMBER_OF_ACTIVITIES + 1
      categories = sorted_categories.take(NUMBER_OF_ACTIVITIES)
      remaining_categories = sorted_categories.drop(NUMBER_OF_ACTIVITIES)
      categories << RemainingCategory.new(remaining_categories)
    end
    categories
  end
end
