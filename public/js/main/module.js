//模块方法
function ajaxIndexTravelsCB(data) {
  if (typeof data == 'object' && data.html) {
    $("#indbbslist").html(data.html);
  }
}

function ajaxIndexTravels(thiz) {
  //旅游攻略
  var bbsT = $("#indbbs").offset().top - 32;

  function scrollbbs() {
    $("#indbbslist").fadeOut(500, function () {
      $("#indbbslist").show();
      $('html, body').animate({scrollTop: bbsT});
    });
  }

  scrollbbs();
  var page = $(thiz).attr('page');
  $.ajax({
    type: 'post',
    dataType: 'jsonp',
    url: "http://user.qyer.com/ajax.php?action=indextravels&page=" + page + "&callback=?"
  })
}

//模块加载完执行的方法

readyScript.this_module = function () {
  //日期选择
  var dates = $("#from, #to").datepicker({
    changeYear: true,
    minDate: new Date(),
    onSelect: function (selectedDate, inst) {
      var option = this.id == "from" ? "minDate" : "maxDate",
        instance = $(this).data("datepicker"),
        date = $.datepicker.parseDate(
          instance.settings.dateFormat ||
            $.datepicker._defaults.dateFormat,
          selectedDate, instance.settings);
      dates.not(this).datepicker("option", option, date);
      if (this.id == "from") {
        var obj_to = new Date(parseInt(inst.selectedYear), parseInt(inst.selectedMonth), parseInt(inst.selectedDay) + 1);
        $("#to").datepicker('setDate', obj_to);
      }
    }
  });

  $("#from").datepicker('setDate', '+2d');
  $("#to").datepicker('setDate', '+4d');


  //滚动焦点图
  $("#ind_focus").slides({
    play: 5000,
    pause: 2500,
    hoverPause: true
  });


  //浮动登录条，存在说明没有登录
  var objTop = $("#_jslogintips");
  if (objTop.length > 0) {
    objTop.offset().top;
    $(window).scroll(function () {
      var winTop = $(document).scrollTop();
      //console.log(winTop);
      if (winTop > objTop) {
        if ((typeof ActiveXObject != "undefined") && (typeof XMLHttpRequest == "undefined")) {
          $(".ind_slogan2").css({"position": "absolute", "top": winTop});
        }
        else {
          $(".ind_slogan2").css({"position": "fixed", "top": "0"});
        }

      }
      else {
        $(".ind_slogan2").css({"position": "", "top": ""});
      }
    });
  }
}