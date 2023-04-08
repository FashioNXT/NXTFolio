$(window).on('load', function() {

    $(document.getElementsByClassName('average-review-rating')).raty({

        readOnly:true,
        numberMax: 5,
        number:5,
        path: '/assets/'
    });

});
