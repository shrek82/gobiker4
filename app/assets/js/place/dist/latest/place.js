/*! place(1.0.0) - JianGang Zhao <zhaojiangang@gmail.com> - 2013-09-21 8:01:46*/
define("place/latest/place", [ "lib/latest/lib", "jquery_slides/latest/slides_jquery" ], function(require, exports, module) {
    var lib = require("lib/latest/lib");
    require("jquery_slides/latest/slides_jquery")($);
    //目的地导航
    $(".gui_nav_item").hover(function() {
        $(this).addClass("gui_nav_item_current");
    }, function() {
        $(this).removeClass("gui_nav_item_current");
    });
    //滚动焦点图
    $("#gui_focus").slides({
        play: 5e3,
        pause: 2500,
        hoverPause: true
    });
    $(document).click(function() {
        if ($("#jn_search_drop").is(":visible")) {
            $("#jn_search_drop").hide();
        }
    });
    $("#jn_search_drop").click(function(event) {
        event.stopPropagation();
    });
    $("#jn_search_input").click(function(event) {
        if ($(this).val() != $(this).attr("placeholder") && $(this).val() != "") {
            $("#jn_search_drop").show();
        }
        event.stopPropagation();
    });
});

