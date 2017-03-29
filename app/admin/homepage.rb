ActiveAdmin.register_page "Homepage" do

  menu parent: 'Service'

  page_action :update_content, method: :post do
    if params[:homepage]
      if file_data = params[:homepage][:greeting_image]
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
    redirect_to admin_homepage_path, notice: "Homepage content was updated"
  end
  page_action :update_outlinks, method: :post do
    if params[:settings]
      if found_setting = Setting.find_by_ident('outer_links')
        found_setting.value = params[:settings][:outer_links].to_s
        found_setting.save
      end
    end
    redirect_to admin_homepage_path, notice: "Outer links were updated"
  end

  content do
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
