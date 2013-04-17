# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('input[name="order[payment_type]"]').filter(':checked').val() == 'credit_card'
    $('div#credit_card_wrap').show()
  else if $('input[name="order[payment_type]"]').filter(':checked').val() == 'paypal'
    $('div#paypal_wrap').show()

  $('input[name="order[payment_type]"]').change ->
    if $(this).val() == 'cash'
      $('div#tip_wrap').hide()
      $('div#credit_card_wrap').hide()
    else if $(this).val() == 'paypal'
      $('div#tip_wrap').show()
      $('div#credit_card_wrap').hide()
    else if $(this).val() == 'credit_card'
      $('div#tip_wrap').show()
      $('div#credit_card_wrap').show()

  # Express Include No. of Persons
  #===================================
  $('select#no_of_persons').change ->
    v = $(this).val()
    vf
    if v == "1"
      vf = v + " person"
    else
      vf = v + " persons"
    $('textarea#order_note').val vf
