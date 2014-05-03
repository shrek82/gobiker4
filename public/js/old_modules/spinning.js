define(function(require, exports, module) {
	var ajaxForm = function(form, options) {
			this.form = form || null;
			this.options = options || {};
		}

	ajaxForm.prototype.submit=function(){
		console.log('loading...');
	}

	module.exports=ajaxForm;
});