class SwitchInput < SimpleForm::Inputs::BooleanInput
  def input(options)
    template.content_tag(:label, class: "label-switch") do
      template.concat @builder.check_box(attribute_name, options.merge(input_html_options), checked_value, unchecked_value)
      template.concat div_checkbox
    end
  end

  def div_checkbox
    "<div class='checkbox'></div>".html_safe
  end
end
