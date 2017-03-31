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

  # Get list of footer links from the setting
  # Check every link to be correct and convert it to the collection of hashes:
  #   { href: 'some_url', class: 'css_class' }
  #
  def collect_outer_footer_links
    outer_links = setting_value(:outer_links).to_s.lines.collect do |olil|
      outer_link = nil
      begin
        uri = URI.parse(olil.strip)
        if %w(http https).include?(uri.scheme)
          css_class = case uri.host.sub(/\Awww\./, '')
                      when "fb.com", "facebook.com" then "soc-lnk-fb"
                      when "github.com"             then "soc-lnk-gh"
                      when "plus.google.com"        then "soc-lnk-gp"
                      when "instagram.com"          then "soc-lnk-ig"
                      when "linkedin.com"           then "soc-lnk-ln"
                      when "tumblr.com"             then "soc-lnk-tb"
                      when "twitter.com"            then "soc-lnk-tw"
                      when "vimeo.com"              then "soc-lnk-vm"
                      when "vine.co"                then "soc-lnk-vn"
                      when "youtube.com"            then "soc-lnk-yt"
                      else
                        ''
                      end
          outer_link = { href: uri.to_s, :class => css_class }
        end
      rescue URI::InvalidURIError
        nil
      end
      outer_link
    end
    outer_links.compact
  end

end
