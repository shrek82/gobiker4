/* beacon */
var _track;
var _$;
var Track = function( user_id ) {
  var ENV = "development";
  var SRC = "http://qt.qyer.com/beacon.gif?";
  var DOMAIN = "qyer.com";
  if ( typeof _track == 'object' ){
    if ( user_id != undefined ) // update user_id, should not happen
      _track.beacon.setUserId( user_id );
    return _track;
  }

  var Beacon = function( user_id ){
    this.setUserId( user_id );

    createCookie( "_guid", readCookie( "_guid" ) || guidGenerator(), 365*2*24*60 );
    this.guid = readCookie( "_guid" );

    createCookie( "_session", readCookie("_session") || _$.now(), 30 );
    this.session = readCookie("_session");

    this.referr = location.href;

  }
  Beacon.prototype.setUserId = function( user_id ){
    this.user_id = user_id == undefined ? 0 : user_id;
  }
  Beacon.prototype.visit = function( data ){
    return this._send( _$.extend( { _type: 'visit' }, data || {} ) );
  }
  Beacon.prototype.link = function( linkEl, e, data ){
    if ( linkEl == undefined )
      return;
    var data = data || {};
    var dstLink = data.dstLink || linkEl.attr( 'href' );
    this._send( _$.extend( { _type: 'link', _url: dstLink }, data ) );
    if ( linkEl.attr( 'target' ) == '_blank' || ( e && ( e.ctrlKey || e.shiftKey || e.metaKey )) || dstLink == 'javascript:void(0);' || linkEl.attr('data-bn-ipg') == 'edittool-1')
      return true;
    else {
      setTimeout( function() {
          location.href = dstLink;
          }, 200 );
      e && e.stopPropagation();
      return false;
    }
  }
  Beacon.prototype.click = function( data ){
    return this._send( _$.extend( { _type: 'click' }, data || {} ) );
  }
  Beacon.prototype.form = function( data ){
    return this._send( _$.extend( { _type: 'form' }, data || {} ) );
  }
  // raw way, should avoid calling this
  Beacon.prototype.send = function( data ){
    this._send( data );
  }

  Beacon.prototype._send = function( data ){
    if ( data == undefined || data._type == undefined )
      return false;
    var params = {
      type: data._type,
      category: data._category || "",
      campaign: data._campaign || "",
      url: data._url || "",
      referer: location.href,
      referer_link: document.referrer,
      guid: this.guid,
      user_id: this.user_id,
      session: this.session,
      timestamp: _$.now()
    };
    delete( data._category ); delete( data._campaign ); delete( data._type ); delete( data._url );
    params.others = _$.param( data );

    var img = new Image();
    img.src = SRC + _$.param( params );

    return true;
  }

  this.beacon = new Beacon( user_id );
  _track = this;

  // guid & cookie funcs
  function guidGenerator() {
    var S4 = function() {
      return (((1+Math.random())*0x10000)|0).toString(16).substring(1);
    };
    return (S4()+S4()+"-"+S4()+"-"+S4()+"-"+S4()+"-"+S4()+S4()+S4());
  }

  function createCookie(name,value,mins) {
    if (mins) {
      var date = new Date();
      date.setTime(date.getTime()+(mins*60*1000));
      var expires = "; expires="+date.toGMTString();
    }
    else var expires = "";
    document.cookie = name+"="+value+expires+"; path=/; domain=" + DOMAIN;
  }

  function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
      var c = ca[i];
      while (c.charAt(0)==' ') c = c.substring(1,c.length);
      if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
  }

  function eraseCookie(name) {
    createCookie(name,"",-1);
  }
}
Track.prototype.visit = function( data ){
  this.beacon.visit( data );
}
// new Track.links( selector )
Track.prototype.links = function( els ){
  var _t = this;
  _$( els ).each( function( index, el ){
      el = _$( el );
      el.click( function( e ){
        return _t.beacon.link( el, e );
      });
  });
}
Track.prototype.link = function( el, e, data ){
  return this.beacon.link( el, e, data );
}
Track.prototype.click = function( data ){
  return this.beacon.click( data );
}
Track.prototype.form = function( formEl, data ){
  var _t = this;
  data  = data || { };
  data._url = formEl.attr( "action" );
  _t.beacon.form( data );
}
Track.prototype.forms = function( formEls, data ){
  var _t = this;
  _$( formEls ).each( function( index, el ){
      el = _$( el );
      el.submit( function( e ){
        data  = data || { };
        data._url = el.attr( "action" );
        _t.beacon.form( data );
        return true;
        });
      });
}

try{
    (function(){
      if ( typeof $ == 'function' && typeof $.browser == 'object' ){
        _$ = $;
        track();
        return;
      }
      var jq = document.createElement( 'script' );
      jq.type = 'text/javascript';
      jq.src = "http://static.qyer.com/js/common/jquery/jquery-1.7.1.min.js";
      jq.onload = function(){ init(); };
      jq.onreadystatechange = function(){
        if ( this.readyState == 'complete' || this.readyState == 'loaded' )
          init();
      };
      var s = document.getElementsByTagName( 'script' )[0];
      s.parentNode.insertBefore( jq, s );
      function init(){
        if ( typeof _$ == 'function' )
          return;
        _$ = jQuery.noConflict();
        track();
      }
      function track(){
          new Track( _qyer_userid ).visit();
          var url = location.href;

          while( true ){
             _$('a.beacon').live('click', function(e){
                  var ext;
                  if(_$(this).attr('data-beacon'))
                      ext = _$(this).attr('data-beacon').split('-');
                  else
                      ext = _$(this).attr('bid_beacon').split('-');
		  category_id = ext.shift();
		  campaign_id = ext.shift();
		  others = ext.join('-');
		  return new Track().link(_$(this), e, {
		      _category: category_id, _campaign: campaign_id, ext: others
	          });
	      });

    
              _$('a[data-bn-ipg]').live('click', function(e){
                  if (_$(this).attr('data-bn-ipg') == 'edittool-1'){
                      flag =  new Track().link(_$(this), e, {
                          _campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')
                      });
                      return false;
                  }
                  else{ 
                      return new Track().link(_$(this), e, {
                          _campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')
                      });
                  }
              });

              _$('div[data-bn-ipg]').live('click', function(e){
                  return new Track().click( {_campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')} );
              });

              
              _$('input[data-bn-ipg]').live('click', function(e){
                  return new Track().click( {_campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')} );
              });
              

              
              _$('form:has(input[data-bn-ipg]), form:has(button[data-bn-ipg])').submit(function(e){
                  new Track().form(_$(this), {
                      _campaign: 'inpage', _category: _$(this).find('[data-bn-ipg]').attr('data-bn-ipg')} );
                  return true;
              });
              
             
              _$('#place_search_input').live('keydown', function(e){
                  if(e.keyCode == 13){
                      new Track().click( {_campaign: 'inpage', _category: '59'} );
                  }
              });

              _$('#jn_search_input').live('keydown', function(e){
                  if(e.keyCode == 13){
                      new Track().click( {_campaign: 'inpage', _category: '5-0'} );
                  }
              });
 
 
              _$('area[data-bn-ipg]').live('click', function(e){
                  return new Track().link(_$(this), e, {
                      _campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')
                  });
              });

              _$('p[data-bn-ipg]').live('click', function(e){
                  return new Track().click( {_campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')} );
              });

              _$('label[data-bn-ipg]').live('click', function(e){
                  return new Track().click( {_campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')} );
              });
    
              _$('span[data-bn-ipg]').live('click', function(e){
                  return new Track().click( {_campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')} );
              });

              _$('button[data-bn-ipg]').live('click', function(e){
                  return new Track().click( {_campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')} );
              });

              _$('li[data-bn-ipg]').live('click', function(e){
                  return new Track().click( {_campaign: 'inpage', _category: _$(this).attr('data-bn-ipg')} );
              });

              var result = /city_id_(\d+)/.exec( url );
              if ( result && result.length > 1 ){ // city page
                  var city_id = result[1];
                  $('.qt_place_city_hotel a').click( function(e){
                          _gaq.push(['_trackEvent','outlink','city_reserve','booking',1]);
                          return new Track().link( $(this), e, {
_category:"city_page", _campaign:"external_link",
target:'hotel', city_id: city_id });
                          });
                  $('.qt_place_city_visa a').click( function(e){
                          _gaq.push(['_trackEvent','outlink','city_reserve','visa',1]);
                          return new Track().link( $(this), e, {
_category:"city_page", _campaign:"external_link",
target:'visa', city_id:city_id });
                          });
                  $('.qt_place_city_assure a').click( function(e){
                          _gaq.push(['_trackEvent','outlink','city_reserve','insurance',1]);
                          return new Track().link( $(this), e, {
_category:"city_page", _campaign:"external_link", 
target:'insurance', city_id:city_id });
                          });
                  break;
              }

              result = /poi_id_(\d+)/.exec( url );
              if ( result && result.length > 1 ){ // poi page
                  var poi_id = result[1];
                  $('.qt_place_poi_siteurl a').click(function(e){
                          _gaq.push(['_trackEvent','outlink','poi_detail','website',1]);
                          return new Track().link( $(this), e, {
_category:"poi_page", _campaign:"official_site", poi_id:poi_id });
                          });
                  $("#frm").submit(function(e){
                          new Track().form($(this), {
_category:"poi_page", _campaign:"booking_form", poi_id:poi_id });
                          _gaq.push(['_trackEvent','outlink','poi_detail','lookup',1]);
                          return true;
                          });
                  break;
              }
 
              result = /hotel\.qyer\.com/.exec(url);
              if ( result ){
                  _$('#js_search_button').live('click', function(e){
                      if( _$('#js_form_poi').attr('value') && _$('#from').attr('value') && _$('#to').attr('value')){
                          if( _$('#js_site1').attr('checked')=='checked' ) {
                              new Track().click({_category: 77, _campaign: 3, ext: '1'});
                          }
                          if( _$('#js_site2').attr('checked') == 'checked' ){
                              new Track().click({_category: 77, _campaign: 3, ext: '2'});
                          }
                      }
                      return true;
                  });
              }
 
              break;
          }
      }
    })();
} catch(e){
    
}
