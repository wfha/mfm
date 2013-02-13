$('.modal').remove();

$('#modal_wrap_cart_item').html('<%=j render "dish_modal" %>');

modal = $('.modal')

modal.find('input').change ->
  note = modal.find('input[name=note]')
  price_adjustment = modal.find('input[name=price_adjustment]')

  note_val = ''

  modal.find('input:checked, input:text').each ->
    if $(this).val()
      note_val += ($(this).val() + ',')

  if note_val.charAt(note_val.length-1) == ','
    note_val = note_val.substring(0, note_val.length-1)

  note.val note_val

  price_adjustment.val $(this).attr("add")

# Click Order Button In The Modal To Submit The Dish Order
modal.find('button.confirm_to_order').click ->
  modal.find('form').submit()

modal.modal('show');
