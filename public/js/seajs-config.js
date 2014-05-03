/*map start*/
seajs.production = true;
if(seajs.production){
    seajs.config({
        map : [
	[
		"candyForm/candyForm.js",
		"candyForm/candyForm-d41d8cd98f00b204e9800998ecf8427e.js"
	]
]
    });
}
/*map end*/
seajs.config({

alias : {

	'$': 'jquery/1.7.2/jquery.js',
	'jquery': 'jquery/1.7.2/jquery.js',
	'_' : 'gallery/underscore/1.4.4/underscore',
	'handlebars' : '/sea-modules/handlebars/1.0.2/handlebars',
	'example-handlebars' : '/sea-modules/js/example/base/handlebars'
},

preload : [
     seajs.production ? 'seajs/seajs-style/1.0.0/seajs-style' : 'seajs/seajs-text/1.0.0/seajs-text-debug'
]
}
);