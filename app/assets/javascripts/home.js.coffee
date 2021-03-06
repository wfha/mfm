# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

  # home/index page
  # =================================================================

  # home/hub page
  # =================================================================
  $('.tag_name_toggle').click ->
    $(this).next().slideToggle()

  # home/delivery page
  # =================================================================
  $('.load_trigger').bind 'ajax:before', ->
    pos = $(this).position()
    $('#load_box_wrap').css({position: "absolute", left: pos.left + 100, top: pos.top }).show()
    $('#load_box').html('<img src="/assets/loading.gif" alt="Loading ...... " style="margin: 150px 150px;"/>')

  $('#load_box_wrap .close').click ->
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
  id_array = [
    'store_overview', 'store_good', 'store_menu', 'store_promo', 'store_info', 'store_review',
    'stores', 'delivery', 'coupons', 'grocery', 'sign_in', 'sign_up'
  ]
  for i in id_array
    if window.location.href.indexOf(i) > 0
      $('#' + i).attr('class', 'active')


  # home/promo page
  # =================================================================
  $(".cfc").click ->
    $(this).hide().siblings(".cfc").show()


  # home/orders page
  # =================================================================
  $("#datepicker").datepicker {
    "format" : "yyyy-mm-dd",
    "weekStart" : 1,
    "autoclose" : true
  }

  $("#dateupdater").click ->
    $(this).attr "href", $(this).attr("href") + "?date=" + $("#datepicker").val()
