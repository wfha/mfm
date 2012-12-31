# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

  # home/stores page
  # =================================================================
  $('button.store_info').each ->
    $(this).click ->
      pos = $(this).position()
      $('div.store_info').eq($(this).index('button.store_info'))
        .css({position: "absolute", left: pos.left + 140, top: pos.top }).toggle()
        .siblings('div.store_info').hide()
        .parents('tr').siblings('tr').find('div.store_info').hide()

  $('.store_info .close').click ->
    $(this).parent().hide()

  $('table tr').hover(
    (ev) ->
      $('ul#markers_list span.foo').eq($(this).index()).trigger('click')
    (ev) ->
  )

  # home/store page
  # =================================================================
  $('.first_child_active').each ->
    $(this).children(':first').addClass('active')

  $('.nav-tabs').each ->
    $(this).find('a').click (e) ->
      e.preventDefault()
      $(this).tab('show')

  $("div[rel=popover]")
    .popover({trigger: 'hover', placement: 'top'})

  # home/store page - highlight the icon based on the url
  # =================================================================
  id_array = ['store_good', 'store_menu', 'store_info', 'store_reviews', 'grocery', 'store', 'sign_in', 'sign_up']
  for i in id_array
    if window.location.href.indexOf(i) > 0
      $('#' + i).attr('class', 'active')




