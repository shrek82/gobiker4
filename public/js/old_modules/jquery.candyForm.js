define(function (require) {
    //引入需要的插件并初始化
    require('jquery.form')($);

    //返回插件的时候，已经初始化好了
    return function ($) {

        //直接ajax提交方法
        $.fn.candyAjaxSubmit = function (options) {
            options = options || {};

            //以下表单引用名称
            var $form = this;

            //默认参数(dataType为返回的数据格式)
            var defaults = {
                url: $form.attr('url') || window.location.href || '',
                type: $form.attr('url') || 'POST',
                dataType: 'json',
                data: null,
                loading: true,
                target: null,
                submitButton: null,
                sendingLabel: '发送中',
                successLabel: '发送成功',
                errorLabel: '发送失败',
                footerLoading:'/static/images/loading.gif',
                beforeSubmit: function () {},
                success: function (data) {
                    return data
                },
                error: function (error) {}
            };

            //继承参数及方法
            var opts = $.extend({}, defaults, options);

            //获取提交按钮
            var $button;
            if (typeof opts.submitButton == 'Object') {
                $button = opts.submitButton;
            } else if (typeof opts.submitButton == 'string') {
                $button = $('#' + opts.submitButton);
            } else {
                $button = $form.find('*[type=submit]');
            }

            //创建表单底部提示div
            var statusTip = $('#statusTip');
            if (!statusTip.length) {
                $form.after('<div id="statusTip" class="display:none"><img src="'+opts.footerLoading+'"></div>');
                statusTip = $('#statusTip');
            }


            //根据发送情况自动处理相关成功或失败实践
            var sysAlert = {

                //数据提交服务器之前
                beforeSubmit: function () {
                    opts.beforeSubmit();
                    //显示loading...
                    statusTip.removeClass('alert alert-success alert-error').html('<img src="'+opts.footerLoading+'">').show();
                    changeLabel($button, opts.sendingLabel, true);
                },

                //服务器响应成功，成功返回数据结果
                success: function (data) {

                    //返回错误提示（例如数据不完整等等），你就随便做点什么吧
                    if (opts.dataType == 'json' && data.error) {
                        setTimeout(function () {
                            statusTip.hide().html(data.error).addClass('alert alert-error').fadeIn(500);
                            changeLabel($button, opts.errorLabel, false);
                            //执行用户自定义错误方法
                            opts.error(data);
                        }, 500);

                        setTimeout(function () {
                            statusTip.fadeOut(300);
                        }, 4000);
                    }
                    //数据保存成功
                    else {
                        setTimeout(function () {
                            statusTip.hide().html('内容发布成功!').addClass('alert alert-success').fadeIn(500);
                            changeLabel($button, opts.successLabel, false);
                            //执行用户自定义成功后方法
                            opts.success(data);
                            $form.resetForm();
                        }, 500);

                        setTimeout(function () {
                            statusTip.fadeOut(300);
                        }, 2000);
                    }



                },
                //发送失败（网络或系统原因，不如超时或程序出错）
                error: function (data) {
                    changeLabel($button, opts.errorLabel, false);
                    statusTip.hide().html('很抱歉,系统超时或出错，请与管理员联系!').addClass('alert alert-error').fadeIn(500);
                    opts.error(data);
                }
            }

            //标签名称及状态及时修改方法
            var changeLabel = function ($button, label, disabled) {
                if ($button[0].tagName == 'INPUT') {
                    $button.attr('value', label);
                } else {
                    $button.html(label);
                }
                return $button.attr('disabled', disabled);
            }

            //异步提交表单
            $form.ajaxSubmit($.extend({}, opts, sysAlert));

        }

        //绑定ajax提交事件
        $.fn.candyForm = function (options) {
            if (this.length) {
                var $form = this;
                $form.bind('submit', function (e) {
                    e.preventDefault();
                    $form.candyAjaxSubmit(options);
                })
            }
        }
        //
    }(jQuery);
});