$('.modal').remove();

$('#modal_wrap').html('<% self.formats = [:mobile] %><%=j render "dish_modal" %>').trigger('create');

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

modal.popup('open');
