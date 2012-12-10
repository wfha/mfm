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
    .css({'cursor': 'pointer', 'background-color': 'lightblue'})

  $('.pre_order').click ->
    $(this).siblings('.modal')
      .modal()
      .find('input').change ->
      note = $(this).siblings('input[name=note]')
      note_val = ''

      $(this).siblings('input:checked, input:text').each ->
        if $(this).val()
          note_val += ($(this).val() + ',')

      if $(this).attr('checked') || $(this).attr('type') =='text'
        note_val += $(this).val()

      if note_val.charAt(note_val.length-1) == ','
        note_val = note_val.substring(0, note_val.length-1)

      note.val note_val
