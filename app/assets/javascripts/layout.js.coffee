$ ->

  # Add ajax loading image for submitting a ticket
  $('#modal_wrap_ticket .modal-body form').bind 'ajax:before', ->
    $('#modal_wrap_ticket .modal-body')
      .html('<img src="/assets/loading.gif" alt="Loading ...... " style="margin: 150px 200px;"/>')


  # Placeholder Polyfill needs label to show placeholder
  # Simple_form creates label with abbr
  # So have to create label and empty inside
  $('form.hide_input_label label.control-label').empty()