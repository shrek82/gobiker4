$(".ui-state-default").live("mouseover",function(){
	dtplus.mover(this);
});


var dtplus = {
	type : "",
	/*
	* @param int endDateMin 第二个时间选择在每一个后几天
	*/
	instance : function (f,t,fcall,tcall,endDateMin,month_num){
		if(typeof(month_num) == "undefined") month_num = 2;
		$( "#"+f ).datepicker({
			minDate: new Date(),
			numberOfMonths: month_num,
			fromobject: f,
			toobject: t,
			beforeShow : function(){
				dtplus.type = f;
			},
			onSelect: function( selectedDate ) {
				var tmpdate = selectedDate.replace(/-0/g,"-");
				tmpdate = tmpdate.split('-');
				if(endDateMin==undefined)endDateMin=1;
				tmpdate = new Date(parseInt(tmpdate['0']), tmpdate['1']-1, parseInt(tmpdate['2'])+endDateMin);
				$( "#"+t ).datepicker( "option", "minDate",  tmpdate);
			},
			onClose: function() {
				if(typeof fcall != 'undefined')fcall();
			}
		});
		$( "#"+t ).datepicker({
			minDate : $("#"+f).datepicker( "getDate" ) ? $("#"+f).datepicker( "getDate" ) : new Date(),
			numberOfMonths: month_num,
			fromobject: f,
			toobject: t,
			beforeShow : function(){
				dtplus.type = t;
				var fromdate = $( "#"+f ).datepicker( "getDate");
				var todate = $( "#"+t ).datepicker( "getDate");
				var pos = 0;
				if (fromdate != null && todate != null){
					var pos = fromdate.getMonth()!=todate.getMonth() ? 1 :0;
				}
				$( "#"+t ).datepicker( "option","showCurrentAtPos",pos);

			},
			onSelect: function( selectedDate ) {
				if(typeof tcall != 'undefined')tcall();
			}
		});
	},


	getdate : function(obj){
		return + new Date($(obj).attr("v"));
		
	},

	mover : function(obj){
		if(dtplus.type=="to"){
			var thisd = dtplus.getdate(obj);
			var fromd = + $("#from").datepicker( "getDate" );
			var tod = + $("#to").datepicker( "getDate" );
			if(fromd>0){
				$(".ui-state-default").each(function(){
					var d = dtplus.getdate(this);
					if(d>fromd && (d<thisd || d<tod)){
						$(this).addClass("ui-state-space");
					}else{
						$(this).removeClass("ui-state-space");
					}
				});
			}
		}
	},
	
	weekstr : function (num){
		var weekinfo=['周日','周一','周二','周三','周四','周五','周六'];
		return weekinfo[num];
	}

};