module ApplicationHelper
  def custom_format_date(date, format)
    date.blank? || format.blank? ? "" : date.strftime(format)
  end
end
