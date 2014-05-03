var QYER={uid:0};
document.write('<div class="qyer_head_login" id="asynclogininfo">');
	document.write('');
	document.write('');
//openid 登录 注册

$("._jsweibologin").live('click', function(){
	//alert('weibo');
	var refer = $(this).attr("url");
	if(!refer){
		var refer = window.location.href;
	}
	/*
		var refer = window.location.href;
		*/
	var url = "/login?action=weibo&popup=1&refer="+refer;
	window.open (url,'newwindow','height=450px,width=600px,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
});

$("._jsqqlogin").live('click', function(){
	
	var refer = $(this).attr("url");
	if(!refer){
		var refer = window.location.href;
	}
	/**/
	/*
		var refer = window.location.href;
		*/
	//var refer = window.location.href;
	var url = "/login?action=qq&popup=1&refer="+refer;
	window.open (url,'newwindow','height=450px,width=600px,top=100,left=300,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
});
