/*
 * 	BeZoom 0.2 - jQuery plugin
 *	written by Benjamin Mock
 *	http://benjaminmock.de/bezoom-jquery-plugin/
 *
 *	Copyright (c) 2009 Benjamin Mock (http://benjaminmock.de)
 *	Dual licensed under the MIT (MIT-LICENSE.txt)
 *	and GPL (GPL-LICENSE.txt) licenses.
 *
 *	Built for jQuery library
 *	http://jquery.com
 *
 */

(function($) {
	$.fn.bezoom = function(options){
		// default settings
		var settings = {
			marginLeft : 10,
			identifier : 'bezoom',
			height : 200,
			width : 200,
			titleSource : 'title',
			imgSource : 'href',
			bgColor : '#5398EE',     // background color for title
			color : '#ffffff',       // font color for title
			size : '0.8em'           // font size for title
		};
		//extending options
		options = options || {};
	   	$.extend(settings, options);

		this.each(function(i){
			var title = $(this).attr(settings.titleSource);
			var imgBig = $(this).attr(settings.imgSource);
			var titleAttribute = $(this).attr("title");

			// saving jquery object of small image
			var img = $(this).find('img');

			$(this).mouseenter(function(e){
				// removing zoom container if exists to avoid duplicates
				$('#'+settings.identifier).remove();
				// removing title to prevent default tooltip
				$(this).attr("title","");
				var imgSmallHeight = $(this).find('img').height();
				var imgSmallWidth = $(this).find('img').width();

				// calculating position for zoom container
				var pos = $(this).position();
				var y = Math.ceil(pos.top-0)-imgSmallHeight;
				var x = Math.ceil(pos.left-0)+imgSmallWidth+settings.marginLeft;

				$('body').append('<div id="'+settings.identifier+'" style="border:1px solid #333; position:absolute; top:'+y+'px;left:'+x+'px;width:'+settings.width+'px;"><div style="background-color:'+settings.bgColor+';color:'+settings.color+';font-size:'+settings.size+';">'+title+'</div><div style="width:'+settings.width+'px;height:'+settings.height+'px;overflow:hidden;position:relative;"><img id="'+settings.identifier+'_img" src="'+imgBig+'" style="position:relative;"></div></div>');
			}).mouseleave(function(){
				// removing zoom container
				$('#'+settings.identifier).remove();
				// setting title back
				$(this).attr("title",titleAttribute);
			});
			$(this).mousemove(function(e){
				// catching mouse movement to position imgBig

				var imgSmallHeight = $(this).find('img').height();
				var imgSmallWidth = $(this).find('img').width();

		    	// calculating image relation
		    	var imgBigWidth = $('#'+settings.identifier+'_img').width();
		    	var imgBigHeight = $('#'+settings.identifier+'_img').height();
				var widthRel = imgSmallWidth / imgBigWidth;
				var heightRel = imgSmallHeight / imgBigHeight;

				// relative mouse position
				var offset = img.position();
				var mouseX = e.pageX - offset.left;
				var mouseY = e.pageY - offset.top;

				// positioning image according to image relation and mouse position
				var imgBigX = Math.ceil((mouseX / widthRel)-(settings.width / 2)) * (-1);
				imgBigX = Math.max((-1*imgBigWidth)+settings.width,imgBigX);
				imgBigX = Math.min(0,imgBigX);

				var imgBigY = Math.ceil((mouseY / heightRel)-settings.height*0.5) *(-1);
				imgBigY = Math.min(0,imgBigY);
				imgBigY = Math.max((-1*imgBigHeight)+settings.height,imgBigY);

				$('#'+settings.identifier+'_img').css('left', imgBigX);
				$('#'+settings.identifier+'_img').css('top', imgBigY);
			});
		});

		return this;
	};
})(jQuery);