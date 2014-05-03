$(function(){
		/*热门目的地菜单显示*/
		$("#js_form_poi").live("focus", function(){
			$(".js_poi_error").html('').hide();
			$(".js_date_error").html('').hide();
			$(".js_hot_poi_menu").show();
		});
		$("#js_form_poi").live("click", function(e){
			e.stopPropagation();
		});

		/*热门目的地菜单隐藏*/
		$(".js_hot_poi_li").live("click", function(e){
			e.stopPropagation();
			$("#js_form_poi").val($(this).find("a").html());
			$(".js_hot_poi_menu").hide();
		});

		$(document).click(function(){
			$(".js_hot_poi_menu").hide();
			$(".js_poi_menu").remove();
		});

		/*目的地搜索联想*/
		$("#js_form_poi").live("keyup", function(){
			$(".js_hot_poi_menu").hide();
			var kw = $(this).val();
			var data_flag=$('.js_poi_error').attr('data-flag');
			if(parseInt(data_flag) != 1 && parseInt(data_flag) != 2 && parseInt(data_flag) != 3) data_flag = 0; 
			$.ajax({
				type: "post",
				dataType:"jsonp",
				url: "http://bx.qyer.com/ajax.php?action=hotelpoi&callback=?",
				data: "kw="+encodeURIComponent(kw)+"&dataflag="+data_flag
			});
		});

		/*$(".js_poi_dd").live("click", function(e){
			e.stopPropagation();
			$("#js_form_poi").val($(this).find(".js_poi_input").html());
			$(".js_poi_menu").remove();
		});*/
		
		//酒店网站搜索
		$("#js_search_button,.js_search_button").live("click", function(){
			var str_poi = $("#js_form_poi").val();
			var data_flag=$('.js_poi_error').attr('data-flag');
			if(data_flag == 3 && str_poi == ''){
				var str_poi = $("#js_form_poi_h").val();
			}
			if(data_flag != 2 && data_flag != 3){
				if(str_poi=='' || str_poi=='输入城市'){
					if(data_flag==1){
						$(".js_poi_error").html('请输入目的地后再搜索').show();
					}else{
						tips.show('请输入目的地后再搜索');
					}
					return;
				}
			}
			if(str_poi == '输入城市') str_poi = "";
			var str_from = $("#from").val();
			if(data_flag != 2 && data_flag != 3){
				if(str_from=='' || str_from=='入住日期'){
					if(data_flag==1){
						$(".js_date_error").html('请选择入住日期').show();
					}else{
						tips.show('请选择入住日期');
					}
					return;
				}
			}
			if(str_from == '入住日期'){
				str_from = "";
			}
			var str_to = $("#to").val();
			if(data_flag != 2 && data_flag != 3){
				if(str_to=='' || str_to=='退房日期'){
					if(data_flag==1){
						$(".js_date_error").html('请选择退房日期').show();
					}else{
						tips.show('请选择退房日期');
					}
					return;
				}
			}
			if(str_to == '退房日期'){
				str_to = "";
			}
			if(data_flag != 2 && data_flag != 3){
				if(!CheckDate(str_from)){
					if(data_flag==1){
						return;
					}else{
						tips.show('入住日期格式错误');
					}
					return;
				}
				if(!CheckDate(str_to)){
					if(data_flag==1){
						return;
					}else{
						tips.show('退房日期格式错误');
					}
					return;
				}
				VDate(document.getElementById('from'));
				VDate(document.getElementById('to'));
			}
			if($("#js_site1").attr('checked')==undefined && $("#js_site2").attr('checked')==undefined && $("#js_site3").attr('checked')==undefined){
				tips.show("请选择提供酒店的网站");
				return;
			}
			_gaq.push(['_trackEvent','booking','hotel','search',1]);
			var int_form_y = "";
			var int_form_m = "";
			var int_form_d = "";
			if(str_from != ''){
				var arr_from = str_from.split('-'); 
				int_form_y =arr_from[0];
				int_form_m =arr_from[1];
				int_form_d =arr_from[2];
			}
			var int_to_y = "";
			var int_to_m = "";
			var int_to_d = "";
			if(str_to != ''){
				var arr_to = str_to.split('-'); 
				int_to_y =arr_to[0];
				int_to_m =arr_to[1];
				int_to_d =arr_to[2];
			}
			var int_show_booking = $("#js_site1").attr('checked')=='checked' ? 1 : 0;
			var int_show_hrs = $("#js_site3").attr('checked')=='checked' ? 1 : 0;
			var int_show_agoda = $("#js_site2").attr('checked')=='checked' ? 1 : 0;
			if(int_show_hrs==1){
				var hrs_url="http://www.hrs.com/?forwardName=defaultSearch&searchType=1&l=zh_cn&location="+encodeURIComponent(str_poi)+"&singleRooms=0&doubleRooms=1&adults=2&startDateDay="+int_form_d+"&startDateMonth="+int_form_m+"&startDateYear="+int_form_y+"&endDateDay="+int_to_d+"&endDateMonth="+int_to_m+"&endDateYear="+int_to_y;
				window.open(hrs_url,'window_hrs','width=1000,height=400,screenX=0,screenY=0,top=0,left=0,toolbar=yes,menubar=yes,scrollbars=yes,location=yes'); 
			}
			if(int_show_booking==1){
				var checkin_year_month = "";
				if(str_from != ''){
					checkin_year_month=int_form_y+"-"+int_form_m;
				}
				var checkout_year_month = "";
				if(str_to != ''){
					checkout_year_month = int_to_y+"-"+int_to_m;
				}
				if(data_flag==1){
					var booking_aid=344298;　//hotel
				}else if(data_flag==2){
					var booking_aid=336174; //首页
				}else if(data_flag==3){
					var booking_aid=355695; //place四期
				}else{
					var booking_aid=335407; //plan
				}
				
				
				var str_cookie = document.cookie;
				var char_link_detail = "01234abcdefghijklmABCDEFGHIJKLM";
				var bool_to_detail = false;
				var str_guid = "";
				if(str_cookie!=""){
					var arr_cookie=str_cookie.split("; ");
					for(var i=0;i<arr_cookie.length;i++){
						 var arr_one_cookie = arr_cookie[i].split("=");
						 if("_guid" == arr_one_cookie[0]){
								 str_guid = arr_one_cookie[1];
								 break;
						 }

					}
				}
				var str_guid_old = str_guid;
				
				/*
				if(str_guid != ''){
					str_guid = str_guid.substr(str_guid.length-1);
					if(char_link_detail.indexOf(str_guid) != -1){
						bool_to_detail = true;
					}
				}else{
					bool_to_detail = true;
				}
				*/
				
				//更改为AB方案
				var abvalue = getABFromGuid();				
				
				var juid=$("#qyer_head_login_hotspot").attr("href");
				if(juid===undefined){
					juid='guid_' + str_guid_old;
				}else{
					juid = juid.replace("http://user.qyer.com/user_","");
					juid += "_guid_" + str_guid_old;
				}
				var str_label = "label=" + juid + ";";
				if(data_flag != 3){
					if(str_poi == '' || str_from == '' || str_to == ''){
						window.open("http://www.booking.com/?aid="+booking_aid);
						return;
					}
				}
				var booking_url="http://www.booking.com/searchresults.html?aid="+booking_aid+"&error_url="+encodeURIComponent("http://www.booking.com/?aid="+booking_aid)+"&si="+encodeURIComponent("ai,co,ci,re,di")+"&label="+juid+"&lang=zh&ifl=&ss="+encodeURIComponent(str_poi)+"&checkin_year_month="+checkin_year_month+"&checkin_monthday="+int_form_d+"&checkout_year_month="+checkout_year_month+"&checkout_monthday="+int_to_d;
				if(data_flag == 3){
					booking_url="http://www.booking.com/searchresults.html?aid="+booking_aid+"&si="+"ai,co,ci,re,di"+"&label="+juid+"&lang=zh&ifl=&ss="+str_poi;
					if(str_from != ''){
						booking_url = booking_url + "&checkin_year_month="+checkin_year_month+"&checkin_monthday="+int_form_d;
					}
					if(str_to != ''){
						booking_url = booking_url + "&checkout_year_month="+checkout_year_month+"&checkout_monthday="+int_to_d;
					}
					booking_url = "http://www.qyer.com/goto.php?url=" + encodeURIComponent(booking_url) + "&hotel_name=" + encodeURIComponent(str_poi + "的酒店") + "&error_url=" + encodeURIComponent("http://www.booking.com/?aid="+booking_aid);
				}
				if(abvalue == 'b'){
					window.open(booking_url);  
					return true;
				}
				var agoda_ajax_url='';
				if(data_flag==1){
					agoda_ajax_url="http://hotel.qyer.com/hotelecho.php";
				}else if(data_flag == 2){
					agoda_ajax_url="http://www.qyer.com/hotelecho.php";
				}else if(data_flag == 3){
					agoda_ajax_url="/ajax.php?action=hotelcity";
				}else{
					agoda_ajax_url="/ajax.php?action=hotelcity";
				}
				$.ajax({
					type: "POST",
					url: agoda_ajax_url,
					data: "show_booking="+int_show_booking+"&show_hrs="+int_show_hrs+"&city="+encodeURIComponent(str_poi)+"&str_from="+str_from+"&str_to="+str_to,
					dataType:"json",
				    async:false,
					beforeSend: function(XMLHttpRequest){
					},
					success: function(rs){
						if(rs.result=="ok"){
							if(rs.data.booking_city_id!=0){
								 if(data_flag == 1){
									booking_aid = 344294;
								 }else if(data_flag == 2){
									booking_aid = 347658;
								 }else if(data_flag==3){
									booking_aid=355695; //place四期
								 }else{
									booking_aid = 335407;
								 }
								 booking_url="http://www.booking.com/searchresults.zh-cn.html?aid="+booking_aid+";"+str_label+"checkin_monthday="+int_form_d+";checkin_year_month="+checkin_year_month+";checkout_monthday="+int_to_d+";checkout_year_month="+checkout_year_month+";city="+rs.data.booking_city_id;
								 if(data_flag == 3){
									 booking_url="http://www.booking.com/searchresults.zh-cn.html?aid="+booking_aid+";"+str_label;
									 if(str_from != ''){
										booking_url = booking_url + "checkin_monthday="+int_form_d+";checkin_year_month="+checkin_year_month;
									}
									if(str_to != ''){
										booking_url = booking_url + ";checkout_monthday="+int_to_d+";checkout_year_month="+checkout_year_month;
									}
									booking_url = booking_url + ";city="+rs.data.booking_city_id;
									booking_url = "http://www.qyer.com/goto.php?url=" + encodeURIComponent(booking_url) + "&hotel_name=" + encodeURIComponent(str_poi + "的酒店");
								 }
							}
							window.open(booking_url); 
							return true;
						}else{
							tips.show(rs.data.msg);
						}	
					}
				});
			}
			if(int_show_agoda==1){
				var agoda_ajax_url='';
				if(data_flag==1){
					agoda_ajax_url="http://hotel.qyer.com/hotelecho.php";
				}else{
					agoda_ajax_url="http://plan.qyer.com/ajax.php?action=hotelcity";
				}
				$.ajax({
					type: "POST",
					url: agoda_ajax_url,
					data: "show_booking="+int_show_booking+"&show_hrs="+int_show_hrs+"&city="+encodeURIComponent(str_poi)+"&str_from="+str_from+"&str_to="+str_to,
					dataType:"json",
				    async:false,
					beforeSend: function(XMLHttpRequest){
					},
					success: function(rs){
						if(rs.result=="ok"){
							if(rs.data.script>0){
								var agoda_url="http://ajaxsearch.partners.agoda.com.cn/partners/partnersearch.aspx?CkInDay="+int_form_d+"&CkInMonth="+int_form_m+"&CkInYear="+int_form_y+"&CkOutDay="+int_to_d+"&CkOutMonth="+int_to_m+"&CkOutYear="+int_to_y+"&CityCode="+rs.data.script+"&CID=1533686&backlink=http://www.qyer.com&header=http://static.qyer.com/html/demo/api_header.html&footer=http://static.qyer.com/html/demo/api_footer.html";
							}else{
								var agoda_url="http://www.agoda.com.cn?CID=1533686&backlink=http://www.qyer.com&header=http://static.qyer.com/html/demo/api_header.html&footer=http://static.qyer.com/html/demo/api_footer.html";
							}
							window.open(agoda_url,'window_agoda','width=1000,height=400,screenX=100,screenY=100,top=100,left=100,toolbar=yes,menubar=yes,scrollbars=yes,location=yes'); 
						}else{
							tips.show(rs.data.msg);
						}	
					}
				});
			}
		});
});

//目的地搜索联想处理函数
function getSearchPoi(data){
	if(typeof(data) == "object"){
		if(data.status == 1){
			$(".js_poi_menu").remove();
			$(".js_poi_input_div").append(data.script);
			$(".js_poi_menu").show();
		}
	}
}

function hotel_add_poi(obj){
	//e.stopPropagation();
	$("#js_form_poi").val($(obj).find(".js_poi_input").html());
	$(".js_poi_menu").remove();
}

//验证日期是不是合法
function CheckDate(str){   
        var   reg   =   /^(\d+)-(\d{1,2})-(\d{1,2})$/;  
        var   r   =   str.match(reg);  
        if(r==null)return   false;  
        r[2]=r[2]-1;  
        var   d=   new   Date(r[1],   r[2],r[3]);  
        if(d.getFullYear()!=r[1])return   false;  
        if(d.getMonth()!=r[2])return   false;  
        if(d.getDate()!=r[3])return   false;  
        return   true;
}

//开始日期结束日期验证
function VDate(obj){
	var this_value = $(obj).val();
	if(!CheckDate(this_value)){
		$(obj).parent().next('span').removeClass().addClass('hotel_calendar_error icon_error').html('格式错误');
		return false;
	}
	$(obj).parent().next('span').removeClass().addClass('hotel_calendar_sunday').html(dtplus.weekstr($(obj).datepicker( "getDate").getDay()));
}
