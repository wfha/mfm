$ ->

  $('#modal_wrap_ticket .modal-body form').bind 'ajax:before', ->
    $('#modal_wrap_ticket .modal-body')
      .html('<img src="/assets/loading_1.gif" alt="Loading ...... " style="margin: 150px 150px;"/>')
