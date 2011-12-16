$(document).ready(function() {	

  if ($('#page_select option:first') != undefined) {
	$("#document").html('');
	var url = $('#page_select').attr('url');
	var page_count = $('#page_select').attr('page_count');
	// iterate over the pages and fetch page content
	if (url != undefined && page_count != undefined) {
	  for(var i = 1; i <= parseInt(page_count); i++) {
		 var page_url = url + '-' + i + '.html';
         retrievePage(page_url, i); 
	  }
    }
  }

	//   $('#page_select').change(function() {
	// var url = $("#page_select option:selected").attr('value');
	// retrievePage(url);
	//   });
	// 
	//   $('#prev_page').click(function() {
	// var prev = $("#page_select option:selected").prev('option');
	// var url = prev.attr('value');
	//     retrievePageAndSelect(url);
	//   });
	// 
	//   $('#next_page').click(function() {
	// var next = $("#page_select option:selected").next('option');
	// var url = next.attr('value');
	//     retrievePageAndSelect(url);
	//   }); 


$('#zoomin').on('click',function() {
	var className = $("#document").attr("class").trim().charAt(5);
	var zoom_protect=parseInt(className);
	if(zoom_protect<=5){
		var zoom_buffer=zoom_protect+1;
		var zoom_level=$("#document").attr("class").replace(className,zoom_buffer);
		$("#document").removeClass();
		$("#document").addClass(zoom_level);
		return false;
	}
});

$('#zoomout').on('click',function() {
	var className = $("#document").attr("class").trim().charAt(5);
	var zoom_protect=parseInt(className);
	if(zoom_protect>1){
		var zoom_buffer=zoom_protect-1;
		var zoom_level=$("#document").attr("class").replace(className,zoom_buffer);
		$("#document").removeClass();
		$("#document").addClass(zoom_level);
		return false;
	}
  });

});

// // loads the page content and sets the page select list
// var retrievePageAndSelect = function(url_val) {
// 	if (url_val != undefined) {
// 		$('#page_select').val(url_val);
// 		retrievePage(url_val);
// 	};
// }

// loads the content for the specific page using the passed url
var retrievePage = function (page_url, page_num) {
	var current_page = 'page_'+page_num
	$('#document').append("<div class='page' id='"+current_page+"'></div>");
	$('#'+current_page).load(page_url, function() {
	   $('#'+current_page).show();
	});	
}

