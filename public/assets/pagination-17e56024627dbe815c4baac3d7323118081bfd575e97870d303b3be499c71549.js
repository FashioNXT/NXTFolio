(function() {
  jQuery(function() {
    if ($('#infinite-scrolling').size() > 0) {
      return $(window).on('scroll', function() {
        var more_posts_url;
        more_posts_url = $('.pagination .next_page a').attr('href');
        if (more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 480) {
          $('.pagination').html('<img id="loadingicon" src="/assets/portfolio/ajax-loader.gif" alt="Fetching More results..." title="Fetching More Results..." />');
          $.getScript(more_posts_url);
        }
        return;
      });
    }
  });

}).call(this);
