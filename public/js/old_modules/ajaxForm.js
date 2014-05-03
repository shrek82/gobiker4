;
(function($) {
	"use strict";
	$.fn.ajaxForm = function(options) {

		console.log('123');

		if(!this.length) {
			log('您还没有选择表单');
			return this;
		}
		else{
			log(this.length);
		}

	};
})(jQuery);