$ ->

  # Add data-native-menu to select input for mobile
  $('select').attr('data-native-menu', false)

  $('#support_icon').click ->
    $('#support_wrap').siblings().hide()
    $('#support_wrap').slideToggle()
    $('#support_wrap form').validate()

  $('#user_icon').click ->
    $('#user_wrap').siblings().hide()
    $('#user_wrap').slideToggle()

  $('#cart_icon').click ->
    $('#cart_wrap').siblings().hide()
    $('#cart_wrap').slideToggle()