module ApplicationHelper

  def link_to_add_checklist_item(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render('checklists/' + association.to_s.singularize + "_fields", f: builder)
    end
    link_to name, 'javascript:void(0)', onclick: "add_checklist_item_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"
  end

end
