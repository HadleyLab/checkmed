ActiveAdmin.register_page "Settings" do

  menu parent: 'Service', label: 'Homepage and footer links'

  page_action :update_homepage, method: :post do
    if params[:homepage]
      if params[:homepage][:remove_greeting_image] == '1'
        if found_setting = Setting.find_by_ident('homepage_greeting_image')
            found_setting.value = nil
            found_setting.save
          end
      elsif file_data = params[:homepage][:greeting_image]
        if found_setting = Setting.find_by_ident('homepage_greeting_image')
          found_setting.value = file_data.open
          found_setting.save
        end
      end
      if found_setting = Setting.find_by_ident('homepage_greeting_text')
        found_setting.value = params[:homepage][:greeting_text].to_s
        found_setting.save
      end
    end
    redirect_to admin_settings_path, notice: "Homepage content was updated"
  end
  page_action :update_outlinks, method: :post do
    if params[:settings]
      if found_setting = Setting.find_by_ident('outer_links')
        found_setting.value = params[:settings][:outer_links].to_s
        found_setting.save
      end
    end
    redirect_to admin_settings_path, notice: "Outer links were updated"
  end

  content title: "Homepage and footer links" do
    columns do

      column do
        panel "Homepage content" do
          render 'form_for_homepage_content'
        end
      end

      column do
        panel "Footer links" do
          render 'form_for_outer_links'
        end
      end

    end
  end

end
