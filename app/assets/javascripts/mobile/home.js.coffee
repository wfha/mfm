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


  # home/store page - highlight the icon based on the url
  # =================================================================
  id_array = [
    'store_overview', 'store_good', 'store_menu', 'store_promo', 'store_info', 'store_review',
    'stores', 'delivery', 'grocery', 'sign_in', 'sign_up'
  ]
  for i in id_array
    if window.location.href.indexOf(i) > 0
      $('#' + i).buttonMarkup({theme: 'b'});