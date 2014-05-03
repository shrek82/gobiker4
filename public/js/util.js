var util={getwordlen:(function(){var byteLength=function(b)
{if(typeof b=="undefined"){return 0}
var a=b.match(/[^\x00-\x80]/g);return(b.length+(!a?0:a.length))};var doublebyte=function(str){return str.replace(/[^\x00-\xff]/g,'*');}
return function(q,g)
{if(g){q=doublebyte(q);}
return byteLength(jQuery.trim(q));}})()};