# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
   $(function () {
        $("ul li").hover(function(){
            $(this).addClass('hs');
            $(this).prevAll().addClass('hs');
        },function(){
            $(this).removeClass('hs');
            $(this).prevAll().removeClass('hs');
        })

        $("ul li").click(function () {
            $(this).addClass('cs');
            $(this).prevAll().addClass('cs');
            $(this).nextAll().removeClass('cs');
        })
    })