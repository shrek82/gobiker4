var search_result_arr = [];
var TID = 0;

function checksearch(){
    if(jQuery("#qyer_head_search_input").val()=="" || jQuery("#qyer_head_search_input").val()==jQuery("#qyer_head_search_input").attr("placeholder")){
        return false;
    }
}


document.writeln("<div class=\"qyer_head_search\" id=\"searchdiv\">");
document.writeln("	<form action=\"http:\/\/search.qyer.com\/index?\" method=\"get\" target=\"_blank\">");
document.writeln("		<input id=\"qyer_head_search_input\" name=\"wd\" autocomplete=\"off\" class=\"qyer_head_search_input\" type=\"text\" value=\"\" placeholder=\"搜索目的地\/用户\/攻略\/锦囊\" />");
document.writeln("		<input type=\"submit\" value=\"搜索\" class=\"qyer_head_search_btn\" onclick=\"return checksearch();\" data-bn-ipg=\"1014\" />");
document.writeln("	<\/form>");
document.writeln("	<div class=\"qyer_head_search_drop\" id=\"qyer_head_search_drop\">");
document.writeln("		");
document.writeln("	<\/div>");
document.writeln("<\/div>");

function getSearchHtml(data){
	search_result_arr[data.keyword] = data;
	if(typeof(data) == "object"){
		if(data.status == 1){
		      jQuery("#qyer_head_search_drop").html("");
              jQuery("#qyer_head_search_drop").html(data.html);
              jQuery("#qyer_head_search_drop").show();
		}else{
		      jQuery("#qyer_head_search_drop").html("");
              jQuery("#qyer_head_search_drop").html(data.html);
              jQuery("#qyer_head_search_drop").hide();
		}
	}
}

function ajaxsearchhtml(){
    keyword=jQuery("#qyer_head_search_input").val();
    if(keyword==""){
    	jQuery("#qyer_head_search_drop").hide();
    	return;
    }
    if("undefined" ==typeof search_result_arr[keyword]){
    	 jQuery.ajax({
  		   type: "get",
             data: "wd="+encodeURI(keyword),
  		   dataType:"jsonp",
  		   url: "http://search.qyer.com/select.php?action=getsearchhtml&callback=?"
    	 });
    }else{
    	getSearchHtml(search_result_arr[keyword]);
    }
       
}

(function($){
    
    $(document).click(function(){
    	
		if($("#qyer_head_search_drop").is(":visible")){
			$("#qyer_head_search_drop").hide();
		}
	});
	$("#qyer_head_search_drop").click(function(event){
		event.stopPropagation();
	});
	$("#searchdiv").click(function(event){
		event.stopPropagation();
	});
    
    
    $("#qyer_head_search_input").focus(function(){
    	var thiz = this;
    	clearTimeout(TID);
    	TID = setTimeout(function(){
    		if($(thiz).val()!=$(thiz).attr("placeholder")){
                ajaxsearchhtml();
            }
    	},100);
        
    });
    $("#qyer_head_search_input").keyup( function() {
    	var thiz = this;
    	clearTimeout(TID);
    	TID = setTimeout(function(){
    		if($(thiz).val()!=$(thiz).attr("placeholder")){
                ajaxsearchhtml();
            }
    	},100);
        
        
    });
    
    var placeholderx = 'placeholder' in document.createElement('input');
    $("#qyer_head_search_input").each(function() {
		if(placeholderx) return false;
		var placeholder=$(this).attr("placeholder");
		if($(this).val()==""){$(this).val(placeholder).css("color","#959595")}
		else if($(this).val()==placeholder){$(this).css("color","#959595")}
		$(this).bind("focus",function(){
			if($(this).val()==placeholder){$(this).val("").css("color","")}
		});
		$(this).bind("blur",function(){
			if($(this).val()==""){$(this).val(placeholder).css("color","#959595")}
		});
	});
    
})(jQuery);
