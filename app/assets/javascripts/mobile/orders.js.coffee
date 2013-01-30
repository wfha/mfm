$ ->
  if $('input[name="order[payment_type]"]').filter(':checked').val() == 'credit_card'
    $('div#credit_card_wrap').show()
  else if $('input[name="order[payment_type]"]').filter(':checked').val() == 'paypal'
    $('div#paypal_wrap').show()

  $('#order_payment_type').on 'change', (event, ui) ->
    if $(this).val() == 'cash'
      $('div#tip_wrap').hide()
      $('div#credit_card_wrap').hide()
    else if $(this).val() == 'paypal'
      $('div#tip_wrap').show()
      $('div#credit_card_wrap').hide()
    else if $(this).val() == 'credit_card'
      $('div#tip_wrap').show()
      $('div#credit_card_wrap').show()
