$(document).ready(function() {
  if ($('#page_link_1') != undefined) {
	url = $('#page_link_1').attr('url');
	loadPage(url);
  }

  $('.page_link').click(function() {
	url = $(this).attr('url');
	loadPage(url);
  });
});

var loadPage = function (page_url) {
	$('#spinner').show();
	$('#document').load(page_url, function() {
		$('#spinner').hide();
	});
}

