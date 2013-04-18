$('#cart_wrap').html('<% self.formats = [:mobile] %><%=j render @cart %>').trigger('create')

$('.modal').popup('close')