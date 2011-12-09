$(document).ready(function() {
  $('.page_link').click(function() {
	page_url = $(this).attr('url');
	$('#spinner').show();
	$('#document').load(page_url, function() {
		$('#spinner').hide();
	});
  });
});

