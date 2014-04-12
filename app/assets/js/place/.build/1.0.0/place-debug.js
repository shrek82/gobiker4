define("place/1.0.0/place-debug", [ "lib/latest/lib-debug", "jquery_slides/latest/slides_jquery-debug" ], function(require, exports, module) {
    var lib = require("lib/latest/lib-debug");
    require("jquery_slides/latest/slides_jquery-debug")($);
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