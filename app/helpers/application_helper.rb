module ApplicationHelper

  def setting_value(setting_name)
    case setting_name
    when :app_humanized_name
      Rails.application.config.app_humanized_name
    else
      nil
    end
  end

end
