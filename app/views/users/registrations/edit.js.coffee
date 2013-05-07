$('#transactions').html '<%= escape_javascript render(@transactions) %>'
$('#paginator').html '<%= escape_javascript(paginate(@transactions, :remote => true).to_s) %>'