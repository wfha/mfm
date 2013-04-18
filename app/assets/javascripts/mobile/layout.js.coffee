$ ->

  # Placeholder Polyfill needs label to show placeholder
  # Simple_form creates label with abbr
  # So have to create label and empty inside
  $('form.hide_input_label label.control-label').empty()



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
