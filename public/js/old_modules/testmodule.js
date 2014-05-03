define(function(require, exports, module) {
	return function($){
		$.fn.testModule=function(username){
			console.log(username);
			console.log(this.html());
		}
	}(jQuery);
})