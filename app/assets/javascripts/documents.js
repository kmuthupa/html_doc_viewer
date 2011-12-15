$(document).ready(function() {	
  // load the first page for the document on view load
  if ($('#page_select option:first') != undefined) {
	url = $('#page_select option:first').attr('value');
	if (url != undefined) {
	  loadPage(url);
    }
  }

  $('#page_select').change(function() {
	url = $("#page_select option:selected").attr('value');
	loadPage(url);
  });

  $('#prev_page').click(function() {
	prev = $("#page_select option:selected").prev('option');
	url = prev.attr('value');
    loadPageAndSetSelect(url);
  });

  $('#next_page').click(function() {
	next = $("#page_select option:selected").next('option');
	url = next.attr('value');
    loadPageAndSetSelect(url);
  }); 
});


// loads the page content and sets the page select list
var loadPageAndSetSelect = function(url_val) {
	if (url_val != undefined) {
		$('#page_select').val(url_val);
		loadPage(url_val);
	};
}

// loads the content for the specific page using the passed url
var loadPage = function (page_url) {
	$('#spinner').show();
	$('#document').html('');
	$('#document').load(page_url, function() {
		$('#spinner').hide();
	});
}

