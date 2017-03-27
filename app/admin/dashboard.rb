ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    # div class: "blank_slate_container", id: "dashboard_default_message" do
    #   span class: "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #   end
    # end

    columns do
      column do
        panel "Key metrics" do
          attributes_table_for Object do
            row 'Total numbers of the registered users' do
              User.count
            end
            row 'Total number of the checklists' do
              Checklist.count
            end
            row 'Total number of checklists visits' do
              UsersChecklistsVisit.count
            end
          end
        end
      end

      column
      column

    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    end
  end # content
end
