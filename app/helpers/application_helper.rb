module ApplicationHelper

  def link_to_add_fields(name, f, association, html_options = nil, &block)
    if block_given?
      html_options, association, f, name = association, f, name, block
    end

    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render('checklists/' + association.to_s.singularize + "_fields", f: builder)
    end

    html_options ||= {}
    # html_options['data-fields-association'] = association
    # html_options['data-fields-template'] = fields; # escape_javascript(fields)
    html_options[:onclick] = "add_nested_item_fields(" \
                                "this, " \
                                "\"#{association}\", " \
                                "\"#{escape_javascript(fields)}\")"
    html_options[:class] = (
                              (html_options[:class] || "") +
                              " chlk-add-nested-fields-btn"
                            ).strip

    if block_given?
      link_to('javascript:void(0)', html_options, &block)
    else
      link_to(name, 'javascript:void(0)', html_options)
    end
  end

end
