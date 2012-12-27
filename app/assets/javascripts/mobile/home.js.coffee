$ ->

  # Add data-native-menu to select input for mobile
  $('select').attr('data-native-menu', false)

  $('#skull').click ->
    $('#cart_wrap').slideToggle()