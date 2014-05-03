// 左侧-POI分类60*60
$(function(){
    $(".place_sort60_item").hover(
        function (){
            if(!$(this).hasClass("place_sort60_item_current"))
            {
                $(this).addClass("place_sort60_item_hover");
            }
        },
        function (){
            if(!$(this).hasClass("place_sort60_item_current"))
            {
                $(this).removeClass("place_sort60_item_hover");
            }
        }
    )
})

// 左侧-旅行指南词条
$(function(){
    $(".ui_guide_item_null").hover(
        function (){
            $(this).css("position","relative").find(".ui_guide_item_null_text").show();
        },
        function (){
            $(this).css("position","").find(".ui_guide_item_null_text").hide();
        }
    )
})

// poi列表页-hover时背景变色
$(function(){
    $(".poi_listing_item").hover(
        function (){
            $(this).addClass("poi_listing_item_current");
        },
        function (){
            $(this).removeClass("poi_listing_item_current");
        }
    )
})

// poi列表页-地图显示隐藏
$(function(){
    $(".poi_listing_item_map").hover(
        function (){
            $(this).css({"position":"relative"}).children(".poi_listing_item_floatMap").show();
        },
        function (){
            $(this).css({"position":""}).children(".poi_listing_item_floatMap").hide();
        }
    )
})

// poi详细页-图片作者显示隐藏
$(function(){
    $(".poi_photo_first").hover(
        function (){
            $(this).find(".poi_photo_writer").show();
        },
        function (){
            $(this).find(".poi_photo_writer").hide();
        }
    )
})

// poi详细页-简介隐藏显示
$(function(){
    $(".poi_detail_introMore").toggle(
        function (){
            $(".poi_detail_intro").hide();
            $(".poi_detail_introMany").show();
            $(this).html("收起");
        },
        function (){
            $(".poi_detail_intro").show();
            $(".poi_detail_introMany").hide();
            $(this).html("展开全部");
        }
    )
})

// album列表页
$(function(){
    $(".place_album_list_item").hover(
        function (){
            $(this).find(".place_album_list_item_mask").show();
            $(this).find(".place_album_list_item_tips").show();
        },
        function (){
            $(this).find(".place_album_list_item_mask").hide();
            $(this).find(".place_album_list_item_tips").hide();
        }
    );
})