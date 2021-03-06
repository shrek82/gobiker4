var QYER_BANNER = function(){
	
	this.href = window.location.href;
	this.html = '';
	this.cookiekey = "banner_before_login_is_hide";
	this.css = '<link href="/static/css/layerfoot.css" rel="stylesheet" type="text/css" />';
	
	this.setCookie = function(name, value){
		var Days = 365;
	    var exp  = new Date();
	    exp.setTime(exp.getTime() + Days*24*60*60*1000);
	    document.cookie = name + "="+ escape (value) + "; path=/;domain=.qyer.com"+";expires="+exp.toGMTString();
	};
	
	this.getCookie = function getCookie(name){
		var arr = document.cookie.match(new RegExp("(^| )"+name+"=([^;]*)(;|$)"));
	    if(arr != null) return unescape(arr[2]); return null;
	}  
	
	this.isnew = this.getCookie("isnew");//1  老用户  无  新用户
	this.refer = document.referrer;
	this.source = null;
	this.getSource = function(){//来源
		var source = this.getCookie("source_url");
		this.source = source;//document.referrer;
		return source;
	}
	this.setSource = function(){//设置来源
		//alert(this.source);
		this.getSource();
		//alert(this.source);
		if(!this.source){//如果来源是空就设置来源
			var www_m = ".+";
			var exp_m = new RegExp("^http:\/\/("+www_m+")\.(qyer|go2eu)\.com", "i");
			//alert(this.refer);
			//alert(22);
			if(this.refer && !exp_m.test(this.refer)){//不是本站的
				//alert(33);
				this.setCookie("source_url", this.refer)
			}
		}
	}
	this.setIsnew = function(){
		if(!this.isnew){
			this.setCookie("isnew", new Date().getTime());
		}
	}
	
	
	this.init = function(){//初始化
		this.setSource();
		
//		if(this.getCookie("close_layer") == "1"){
//		return false;
//	}
		if(QYER.uid>0){
			return false;
		}
		
		if(this.href == "http://www.qyer.com/"){
			return false;
		}
		
		var www_m = "m|login";
		var exp_m = new RegExp("^http:\/\/("+www_m+")\.(qyer|go2eu)\.com", "i");
		if(exp_m.test(this.href)){//不 m.qyer.com 不显示
			return false;
		}
		
		//jQuery.get("http://www.qyer.com/api.php?action=banner&url="+encodeURIComponent(this.href)+"&isnewuser="+this.isnew+"&source="+encodeURIComponent(this.getSource()),function(rs){
		//	//alert(rs);
		//	if(rs !==''){
		//		jQuery("body").append(rs);
		//		beforeloginshow();
		//	}
		//});

		this.setIsnew();
		//淡出效果
		function beforeloginshow(){
			setTimeout(function(){
				jQuery("._jsbeforelogindiv").fadeIn(500,function(){
					jQuery("._jsbeforelogindiv").show();
				});
			},500);
			
			setTimeout(function(){
				jQuery("._jsbeforelogindiv").fadeIn(500,function(){
					jQuery("._jsbeforelogindiv").show();
				});
			},1500);
			return false;
		}
		
		//从下往上滑动效果
		function beforeloginup(){
			setTimeout(function(){
				jQuery("._jsbeforelogindiv").slideDown(1000,function(){
					jQuery("._jsbeforelogindiv").show();
				});
			},500);
			
			setTimeout(function(){
				jQuery("._jsbeforelogindiv").slideDown(1000,function(){
					jQuery("._jsbeforelogindiv").show();
				});
			},1500);
		}
	}
};

jQuery(function() {
	banner = new QYER_BANNER();
	banner.init();
	
	var url_com = "";
	//new
	bbs_guide_tips = 0;
	
	jQuery("._jslogin").live("click", function(){
		var url_com = jQuery(this).attr("url");
		if(!url_com){
			var url_com = window.location.href;
		}
		if(/^http:\/\/bbs\.qyer\.com\//.test(window.location.href)){
			ajaxlogin(0,'','bbsajax.php', 'reload','',url_com);
		}else{
			ajaxlogin(0,'','ajax.php','reload','',url_com);
		}
	});
	
	jQuery("._jslogin_reg").live("click", function(){
		var url_com = jQuery(this).attr("url");
		if(!url_com){
			var url_com = window.location.href;
		}
		if(/^http:\/\/bbs\.qyer\.com\//.test(window.location.href)){
			ajaxlogin(0,'','bbsajax.php','reload','reg',url_com);
		}else{
			ajaxlogin(0,'','ajax.php','reload','reg',url_com);
		}
	});
	
	jQuery(".qyer_layer_close").live("click", function(){
		jQuery("._jsbeforelogindiv").fadeOut(1000);
        //jQuery("._jsbeforelogindiv").remove();
	});
	
});
function reload(){
	setTimeout('window.location.reload()',2500);
}
