define(function(require,exports,module) {
    var ajaxRequest=function(url,options){
        if(typeof url==='undefined'||typeof url===null){
            console.log('not defined url');
            return false;
        }
        this.url=url;
        this.opt=options||{};
    }

    ajaxRequest.prototype.send=function(){
        console.log(this.url);
    }

    module.exports.ajaxRequest=ajaxRequest;
})