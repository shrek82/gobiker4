$.fn.candyForm = function(options) {
    //无表单提示
    if (!this.length) {
        log('表单不存在，请检查！');
        return this;
    }

    //选项
    var opt= $.extend({},{
        action: false,
        method: 'post',
        data_type: 'html',
        timeout: 3000,
        url: false,
        clearForm: false,
        errorDisplayType: 'formError',
        loading: false,
        btn: false,
        redirect: false,
        callback: false,
        before: false,
        error: false,
        statusTools: false,
        submitButton: 'submit_button',
        textSuccess: '成功发送',
        textSending: '发送中',
        textError: '重试'
    },options);

    //绑定提交事件
    this.on('submit', function(e) {
        e.preventDefault();
        $(this).ajaxSubmit({
            target: '#output'
        });
    });


    //打印log
    function log(msg) {
        if (window.console && window.console.log) {
            window.console.log(msg);
        }
        else if (window.opera && window.opera.postError) {
            window.opera.postError(msg);
        }
    }
}