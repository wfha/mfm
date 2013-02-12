$('.modal').remove();

$('#modal_wrap_order').html('<%=j render "order_modal" %>');

$('.modal').modal('show');
