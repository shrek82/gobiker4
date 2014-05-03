//页面向上小箭头
jQuery(function($){

    var doc = $(document);
    var win = $(window);

    if(doc.width() > 1024){
        var ui_upward="<div class='ui_upward_wrapper'><div class='ui_upward_icon' title='返回顶部'></div></div>";
        $(ui_upward).prependTo("body");

        var icon = $(".ui_upward_icon");
        var iconH = icon.height(); //获取icon高度

        win.scroll(function(){

            var top = win.height() - iconH - 10; //定义当前icon应该所属的top值
            var left = (doc.width()-980)/2 + 980;

            if($(".qyer_footer").length > 0){
                var maxT = doc.height() - $(".qyer_footer").height() - doc.scrollTop() - iconH - 10; //定义icon最大top值
                if($(window).height() > maxT){
                    top = maxT;
                }
            }
            //console.log(maxT);

            if(doc.scrollTop() == 0){
                icon.css({"display":"none"});
            }
            else{
                icon.css({"display":"block","left":left,"top":top});
            }
        });

        icon.click(function(){
            //doc.scrollTop(0);
            $("body,html").animate({scrollTop:0});
        });

        icon.hover(function(){
            $(this).addClass("ui_upward_icon_hover");
        },function(){
            $(this).removeClass("ui_upward_icon_hover");
        });
    }
});