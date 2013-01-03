# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#$ ->
#  $.fn.extend
#    smart_float: ->
#      position = (e)->
#        y_start = e.position().top
#
#        $(window).scroll ->
#          scrolls = $(this).scrollTop()
#          y_stop = $('#main').offset().top + $('#main').height() - e.height() - 30
#          x_start = $('#main').offset().left + $('#main').width() + 20
#
#          if scrolls > y_start && scrolls < y_stop
#            if window.XMLHttpRequest
#              e.css position: "fixed", top: 0, left:x_start
#            else
#              e.css top: scrolls, left:x_start
#          else if scrolls >= y_stop
#            e.css position: "absolute", top: y_stop, left:x_start
#          else
#            e.css position: "absolute", top: y_start, left:x_start
#
#      return $(this).each ->
#        position $(this)
#
#  $('#side').smart_float()

$ ->
  $('#side').affix
    offset:
      top: $('#side').position().top - 60,
      bottom: 0
