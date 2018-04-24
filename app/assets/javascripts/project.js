$('#use_dollars').val() ? $('#rates_table').show() : $('#rates_table').hide()

$('#use_dollars').on('change',
  function(){
  $('#use_dollars').find('option:selected').val() != "true" ? $('#rates_table').hide() : $('#rates_table').show()
});
