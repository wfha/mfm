# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('#side').size() > 0
    $('#side').affix
      offset:
        top: $('#side').position().top - 60,
        bottom: 0

  if $('#side_map').size() > 0
    $('#side_map').affix
      offset:
        top: $('#side_map').position().top - 60,
        bottom: 0
