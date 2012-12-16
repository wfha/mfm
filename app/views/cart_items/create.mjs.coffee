$('.modal').popup('close')

# Has problem below, not solved yet
$('.cart').html ->
  '<% self.formats = [:mobile] %><%=j render @cart %>'
.trigger('create')
