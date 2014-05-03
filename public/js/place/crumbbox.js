$(function(){
	var box,x,y,h;
	var hide;
	var my;
	
	function layhide(){
		$(".qyer_head_crumb .arrow").removeClass("hover");
		$(".qyer_head_crumb_pulldown").hide();
	}
	
	$(".qyer_head_crumb .arrow").hover(function(){
		my = $(this);
		box = my.parent(".drop");
		h = box.height();
		x = box.offset().left;
		y = box.offset().top;
        
        var targetclass=$(this).attr("data");
		
		window.clearTimeout(hide);
		$(".qyer_head_crumb .arrow").removeClass("hover");
		$(this).addClass("hover");
        $(".qyer_head_crumb_pulldown").hide();
		$("."+targetclass).css({left:x,top:y+h}).show();
		
	},function(){});
	
	$(".qyer_head_crumb .drop").hover(function(){},function(){
		hide=window.setTimeout(layhide,300);
	});
	
	$(".qyer_head_crumb_pulldown").hover(function(){
		window.clearTimeout(hide);
		my.addClass("hover");
		$(this).show();
	},function(){
		hide=window.setTimeout(layhide,300);
	});
});