xml.instruct!
xml.Response do
  xml.Gather(:action => @post_to, :numDigits => 1) do
    xml.Say "Hello, we are calling from meals for me."
    xml.Say "We just sent you an online order, invoice number is #{@order_id}."
    xml.Say "If correct, please press 1. If not, please press 2."
  end
end