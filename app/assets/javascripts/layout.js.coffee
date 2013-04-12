$ ->

  # Add ajax loading image for submitting a ticket
  $('#modal_wrap_ticket .modal-body form').bind 'ajax:before', ->
    $('#modal_wrap_ticket .modal-body')
      .html('<img src="/assets/loading.gif" alt="Loading ...... " style="margin: 150px 200px;"/>')


  # Placeholder Polyfill needs label to show placeholder
  # Simple_form creates label with abbr
  # So have to create label and empty inside
  $('form.hide_input_label label.control-label').empty()

  $('.sni').jrumble(
    x: 4, y: 4,
    rotation: 2,
    speed: 50
  ).hover(
    (ev) ->
      $(this).trigger('startRumble')
    (ev) ->
      $(this).trigger('stopRumble')
  )


  # Edit the width of file input
  # File input width cannot be set in css for firefox, so has to use size=5
  # Maybe due to carrierwave, input_html: {size: 5} doesn't work, so implement it in JS
  $('input[type=file]').attr size: 5



  # Facebook SDK
  # =============================================================================

  $('body').prepend('<div id="fb-root"></div>')
  $.ajax
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js"
    dataType: 'script'
    cache: true

window.fbAsyncInit = ->
  FB.init
    appId: 450339078377328
    xfbml: 1


