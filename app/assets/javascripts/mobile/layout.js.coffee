$ ->


  # Placeholder Polyfill needs label to show placeholder
  # Simple_form creates label with abbr
  # So have to create label and empty inside
  $('form.hide_input_label label.control-label').empty()