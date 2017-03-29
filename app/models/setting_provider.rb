# SettingProvider allows you get and set settings
# SettingProvider stores often settings values for db queries economy
class SettingProvider
  include Singleton

  def value_of(setting_ident)
    if check_aggregator(setting_ident)
      # get value from aggregator
      aggregated_value(setting_ident)
    else
      #  ask database if aggregator isn't include this setting value
      found_setting = Setting.find_by_ident(setting_ident) unless found_setting
      found_setting ? found_setting.value : nil
    end
  end

  def set_value_for(setting_ident, new_value)
    success_flag = false
    if found_setting = Setting.find_by_ident(setting_ident)
      found_setting.value = new_value
      success_flag = found_setting.save
      update_aggregator found_setting.ident, found_setting.value if success_flag
    end
    success_flag
  end

  def reload_aggregator!
    fill_aggregator
  end

  private

  def aggregated_value(setting_ident)
    return nil unless @aggregator
    @aggregator[setting_ident.to_s]
  end

  # Aggregator includes preloaded values with 'often' attruibute == `true`
  def check_aggregator(setting_ident)
    fill_aggregator unless @aggregator
    @aggregator.has_key? setting_ident.to_s
  end

  def update_aggregator(setting_ident, new_value)
    fill_aggregator unless @aggregator
    if @aggregator.has_key? setting_ident.to_s
      @aggregator[setting_ident.to_s] = sset.new_value
    end
  end

  # Fill aggregator with first request to any setting value
  def fill_aggregator
    @aggregator = {}
    Setting.where(often: true).each do |sset|
      @aggregator[sset.ident] = sset.value
    end
  end
end
