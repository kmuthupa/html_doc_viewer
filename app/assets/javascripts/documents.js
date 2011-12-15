$(document).ready(function() {	
  if ($('#page_link_1') != undefined) {
	url = $('#page_link_1').attr('value');
	loadPage(url);
  }

  $('#page_select').change(function() {
	url = $("#page_select option:selected").attr('value');
	loadPage(url);
  });

  $('#prev_page').click(function() {
	
	
  });

  $('#next_page').click(function() {
	
	
  }); 
});

var loadPage = function (page_url) {
	$('#spinner').show();
	$('#document').html('');
	$('#document').load(page_url, function() {
		$('#spinner').hide();
	});
}

