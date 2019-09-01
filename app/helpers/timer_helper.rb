module TimerHelper
  def hours_and_minutes_for_timer timer
    end_time = timer.ends_at || Time.now
    duration = distance_of_time_in_words(end_time - timer.starts_at)

    "Timer: <span clas='timer'>#{duration}</span>".html_safe
  end
end
