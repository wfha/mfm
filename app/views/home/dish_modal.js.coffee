$('.modal').remove();

$('#modal_wrap').html('<%=j render "dish_modal" %>');

modal = $('.modal')

modal.find('input').change ->
  note = modal.find('input[name=note]')
  note_val = ''

  modal.find('input:checked, input:text').each ->
    if $(this).val()
      note_val += ($(this).val() + ',')

  if note_val.charAt(note_val.length-1) == ','
    note_val = note_val.substring(0, note_val.length-1)

  note.val note_val

modal.modal('show');
