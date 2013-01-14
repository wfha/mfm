# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $('input[name="order[payment_type]"]').filter(':checked').val() == 'credit_card'
    $('div#card_wrap').show()

  $('input[name="order[payment_type]"]').change ->
    if $(this).val() == 'cash'
      $('div#card_wrap').slideUp 'slow'
    else if $(this).val() == 'credit_card'
      $('div#card_wrap').slideDown 'slow'
