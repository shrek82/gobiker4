var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-185023-1']);
_gaq.push(['_setDomainName', 'qyer.com']);
_gaq.push(['_setSiteSpeedSampleRate',10]);
_gaq.push(['_addIgnoredRef', 'qyer.com']);
_gaq.push(['_addOrganic','soso','w']);
_gaq.push(['_addOrganic','sogou','query']);
_gaq.push(['_addOrganic','baidu','word']);
_gaq.push(['_addOrganic','baidu','q1']);
_gaq.push(['_addOrganic','baidu','q2']);
_gaq.push(['_addOrganic','m.baidu','word']);
_gaq.push(['_addOrganic','so.360','q']);
_gaq.push(['_trackPageview']);

  var _qyer_userid = QYER.uid;
  (function() {

    var qt = document.createElement('script'); qt.type = 'text/javascript'; qt.async = true;

    qt.src = 'http://qt.qyer.com/beacon.js';
    //var bb = new Beacon();
    

    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    
    
    var bookingjs = document.createElement('script'); bookingjs.type = 'text/javascript'; bookingjs.async = true;
    bookingjs.src = 'http://static.qyer.com/js/common/bookingtrack.js';
    
    var s = document.getElementsByTagName('script')[0];s.parentNode.insertBefore(qt, s); s.parentNode.insertBefore(ga, s);s.parentNode.insertBefore(bookingjs, s);
  })();

function indexiconcb(data){
	if(typeof data == 'string'){
		$("#_jsiconrand").html(data) ;		
	}
}
$(function(){
	var dates = $( "#from, #to" ).datepicker({
		changeYear: true,
		minDate: new Date(),
		onSelect: function( selectedDate ,inst) {
			var option = this.id == "from" ? "minDate" : "maxDate",
				instance = $( this ).data( "datepicker" ),
				date = $.datepicker.parseDate(
					instance.settings.dateFormat ||
					$.datepicker._defaults.dateFormat,
					selectedDate, instance.settings );
			dates.not( this ).datepicker( "option", option, date );
            if(this.id == "from"){
                var obj_to = new Date(parseInt(inst.selectedYear), parseInt(inst.selectedMonth), parseInt(inst.selectedDay)+1);                
                $( "#to" ).datepicker('setDate',obj_to);
            }
		}
	});
    $( "#from" ).datepicker('setDate','+2d');
    $( "#to" ).datepicker('setDate','+4d');
    
	
	//焦点图
	$("#ind_focus").slides({
		play: 5000,
		pause: 2500,
		hoverPause: true
	});
	

	
	
	$.ajax({
		type:"post",
		dataType:"jsonp",
		url:"http://static.qyer.com/?action=indexicon&callback=?"
	});
	
	if(QYER.uid && QYER.uid>0){
		$("#_jslogintips").hide();
		$("#_jsloginedtips").show();
	}else{
		$("#_jsloginedtips").hide();
		$("#_jslogintips").show();
	}
	
    var objTop = $(".ind_slogan2_fix").offset().top;
    $(window).scroll(function(){
        var winTop = $(document).scrollTop();
        //console.log(winTop);
        if(winTop>objTop){
        	if((typeof ActiveXObject != "undefined") && (typeof XMLHttpRequest == "undefined")){
                $(".ind_slogan2").css({"position":"absolute","top":winTop});
            }
            else{
                $(".ind_slogan2").css({"position":"fixed","top":"0"});
            }

        }
        else{
            $(".ind_slogan2").css({"position":"","top":""});
        }
    });	
});
function ajaxIndexTravelsCB(data){
	if(typeof data == 'object' && data.html){
		$("#indbbslist").html(data.html);
	}
}
function ajaxIndexTravels(thiz){
	//旅游攻略
	var bbsT = $("#indbbs").offset().top-32;
	//console.log(bbsT);
	function scrollbbs(){
        $("#indbbslist").fadeOut(500,function(){
            $("#indbbslist").show();
			$('html, body').animate({scrollTop:bbsT});
        });
	}
	scrollbbs();
	
	var page = $(thiz).attr('page');
	$.ajax({
		type:'post',
		dataType:'jsonp',
		url:"http://user.qyer.com/ajax.php?action=indextravels&page="+page+"&callback=?"
	})
}