<% if @order.handled %>
  $("tr#order_<%= @order.id %>").css("background", "")
<% else %>
  $("tr#order_<%= @order.id %>").css("background", "#ffffff")
<% end %>