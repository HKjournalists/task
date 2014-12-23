(function($){
    $.fn.fixlayer=function(config){
        var obj=this;
        var defaultConfig={
            position:"absolute",
            width:"100%",
            zindex:9999,
            timer:10
        }
        var config=$.extend(defaultConfig,config);  //对象合并
        var contentDiv=obj.children("div").height(); 
        var offsetTop=$(window).height()+$(window).scrollTop()-contentDiv;
        obj.children("iframe").height(contentDiv);
        obj.css({"z-index":config.zindex,"width":config.width,"height":contentDiv,"position":config.position,"background":config.background});
        //obj.animate({"top":offsetTop+"px"}, {duration:config.timer, queue: false });
        obj.css({"top":offsetTop+"px"});
        $(window).resize(function(){
            offsetTop=$(window).height()+$(window).scrollTop()-contentDiv;
            //obj.animate({"top":offsetTop+"px"}, {duration:config.timer, queue: false });
            obj.css({"top":offsetTop+"px"});
        });

        $(window).scroll(function(){
            offsetTop=$(window).height()+$(window).scrollTop()-contentDiv;
            //obj.animate({"top":offsetTop+"px"}, {duration:config.timer, queue: false });
            obj.css({"top":offsetTop+"px"});
        });
    }
})(jQuery);