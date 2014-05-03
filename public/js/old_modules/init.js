require('jquery.form')($);

    var ajaxForm = function(options) {
            var defaults = {
                url: '',
                type: 'POST',
                loading: true,
                sendingLabel: '发送中',
                successLabel: '发送成功',
                errorLabel: '发送失败',
                before: function() {},
                success: function() {},
                error: function() {}
            };
            this.options = $.extend({}, defaults, options);
        }

    ajaxForm.prototype.submit = function() {
        console.log('action is' + this.form.attr('action'));
        console.log('formSerialize is' + this.form.formSerialize());
        this.form.ajaxSubmit();
        return false;
    }

    module.exports = ajaxForm;
});