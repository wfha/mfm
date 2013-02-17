$('.modal').remove();

$('#modal_wrap_cart_item').html('<%=j render "dish_modal" %>');

modal = $('.modal')

# Click Order Button In The Modal To Submit The Dish Order
# Need to Check if must inputs are filled before submitting
modal.find('button.confirm_to_order').click ->
  flag = true

  modal.find('div.dish_choice_wrap').each ->
    if $.trim($(this).attr("must")) == "true"
      if $.trim($(this).attr("type")) == "radio" || $.trim($(this).attr("type")) == "checkbox"
        if $(this).find("input:checked").length == 0
          flag = false

  if flag
    note = modal.find('input[name=note]')
    price_adjustment = modal.find('input[name=price_adjustment]')
    note_val = ''
    price_adjustment_val = 0

    modal.find('input:checked, input:text').each ->
      if $(this).val()
        note_val += ($(this).val() + ',')
        price_adjustment_val += Number($(this).attr("add"))

    if note_val.charAt(note_val.length-1) == ','
      note_val = note_val.substring(0, note_val.length-1)

    note.val note_val
    price_adjustment.val price_adjustment_val

    modal.find('form').submit()

modal.modal('show');
