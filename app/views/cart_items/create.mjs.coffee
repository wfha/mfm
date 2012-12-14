<% self.formats = [:mobile] %>

$('#cart').html('<%=j render @cart %>').trigger('create');

$('.modal').popup('close');
