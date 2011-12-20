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
  
  
 /********page nav*********/ 

$("#next_page").on('click',function(){
var pageLimit=$("#page_select").attr("page_count");
var nextPage=parseInt($("#page_select").val())+1;

if(nextPage<= pageLimit){
var pageNumber=("#page_"+ nextPage);
pageScroll(pageNumber);
$("#page_select").val(nextPage);
}

});


$("#prev_page").on('click',function(){
var pageLimit=$("#page_select").attr("page_count");
var prevPage=parseInt($("#page_select").val())-1;

if(prevPage !==0){
var pageNumber=("#page_"+ prevPage);
pageScroll(pageNumber);
$("#page_select").val(prevPage);
}

});


$("#page_select").on('change',function(){
var pageNumber=("#page_"+$(this).val());
pageScroll(pageNumber);

});
  
  
function pageScroll(number){
$("#doc_container").scrollTo(number,1000,{easing:'esoincub'}	);
 return false
}

$.easing.esoincub = function(x, t, b, c, d) {
		if ((t/=d/2) < 1) return c/2*t*t*t + b;
		return c/2*((t-=2)*t*t + 2) + b;	
};


/********page jump*********/
  

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

 /********zoom********/ 

$('#zoomin').on('click',function() {
	var className = $("#document").attr("class").trim().charAt(5);
	var zoom_protect=parseInt(className);
	if(zoom_protect<=4){
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

// loads the content for the specific page using the passed url
var retrievePage = function (page_url, page_num) {
	var current_page = 'page_'+page_num
	$('#document').append("<div class='page' id='"+current_page+"'></div>");
	$('#'+current_page).load(page_url, function() {
	   $('#'+current_page).show();
	});	
}




