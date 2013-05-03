<% if @ticket.handled %>
  $("tr#ticket_<%= @ticket.id %>").css("background", "")
<% else %>
  $("tr#ticket_<%= @ticket.id %>").css("background", "#ff0000")
<% end %>