<% if @result %>
  alert "Your refund has been issued!"
  $("#cash_back, #cash_back_in_bar").html("<%= number_to_currency @cash_back %>")
  $("#cash_back_details").prepend "<tr><td><%= @tran.created_at.strftime('%Y-%m-%d %H:%M %P') %></td><td><%= @tran.name %></td><td><%= number_to_currency @tran.amount %></td></tr>"
<% else %>
  alert "Not enough rewards on your account!"
<% end %>