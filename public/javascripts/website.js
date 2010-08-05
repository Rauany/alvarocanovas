

SlideShow = {
  timeout: null,
  setup: function(){
    $(".category_menu.menu").livequery(
        function(){ SlideShow.clear() },
        function(){ SlideShow.clear() }
      );
  },
  launchWithDelay: function(url){
    SlideShow.timeout = setTimeout(function(){SlideShow.callback(url)},10000)
  },
  clear: function(){
    clearTimeout(SlideShow.timeout)
  },
  callback: function(url){
    $.get(url);
  }
};

var clearSlideShowTimeout = function(){
  clearTimeout(slideShowTimeout);
};

(function($){

  var opt = {
    topBefore: '20px',
    topAfter: '55px'
  };

  $.fn.mainMenu = function(){
    this.find('ul').hide();
    $.extend(this, instanceFunctions);

    $menu = this

    //Animate subMenus
    $menu.find('ul>li').hover(
      function(){
        $(this).find('ul').fadeIn();
      },
      function(){
        $(this).find('ul').fadeOut();
      }
    );

    //Animate MainMenu
    $menu.hover(
      function(){
        $menu.scrollDown()
      },
      function(){
        $menu.scrollUp()
      }
    );
    
    return this
  }

  var instanceFunctions = {
    scrollDown: function(){
      $menu = this ;
      $menu.find('h2')
        .animate({top: opt.topAfter}, function(){
          $menu.find('>ul').fadeIn();
      });
      $menu.find('h2 span').fadeOut();
    },
    scrollUp: function(){
      $menu = this;
      $menu.find('h2')
       .animate({top: opt.topBefore}, function(){
         $menu.find('>ul').fadeOut();
      })
      $menu.find('h2 span').fadeIn('slow');
    }
  }

})(jQuery);

var Gallery = {

  onMouseOutOpacity: 0.67,

  classic: {
    delay:                     5000,
    numThumbs:                 10,
    preloadAhead:              10,
    enableTopPager:            false,
    enableBottomPager:         false,
    imageContainerSel:         '#slideshow',
    controlsContainerSel:      '#slideShowControls',
    captionContainerSel:       '#slideShowCaption',
    loadingContainerSel:       '#loading',
    renderSSControls:          true,
    renderNavControls:         false,
    playLinkText:              'Play',
    pauseLinkText:             'Pause',
    prevLinkText:              '&lsaquo; Previous Photo',
    nextLinkText:              'Next Photo &rsaquo;',
    nextPageLinkText:          'Next &rsaquo;',
    prevPageLinkText:          '&lsaquo; Prev',
    enableHistory:             false,
    autoStart:                 true,
    syncTransitions:           true,
    defaultTransitionDuration: 900,

    onSlideChange: function(prevIndex, nextIndex) {
      // 'this' refers to the gallery, which is an extension of $('#thumbs')
      this.find('ul.thumbs').children()
        .eq(prevIndex).fadeTo('fast', Gallery.onMouseOutOpacity).end()
        .eq(nextIndex).fadeTo('fast', 1.0);

      // Update the photo index display
      this.$captionContainer
        .html( (nextIndex+1) +' / '+ this.data.length);
    },
    onPageTransitionOut: function(callback) {
      this.fadeTo('fast', 0.0, callback);
    },
    onPageTransitionIn: function() {
      var prevPageLink = this.find('a.prev').css('visibility', 'hidden');
      var nextPageLink = this.find('a.next').css('visibility', 'hidden');

      // Show appropriate next / prev page links
      if (this.displayedPage > 0)
        prevPageLink.css('visibility', 'visible');

      var lastPage = this.getNumPages() - 1;
      if (this.displayedPage < lastPage)
        nextPageLink.css('visibility', 'visible');

      this.fadeTo('fast', 1.0);
    }
  }

};



(function($){
  $.fn.gallery = function(thema, options){

    // Initially set opacity on thumbs and add
    // additional styling for hover effect on thumbs
    $('#thumbs ul.thumbs li, div.navigation a.pageLink').opacityrollover({
      mouseOutOpacity:   Gallery.onMouseOutOpacity,
      mouseOverOpacity:  1.0,
      fadeSpeed:         'fast',
      exemptionSelector: '.selected'
    });

    gallery = this.galleriffic($.extend({},Gallery[thema],options))

    /**************** Event handlers for custom next / prev page links **********************/

    gallery.find('a.prev').click(function(e) {
      gallery.previousPage();
      e.preventDefault();
    });

    gallery.find('a.next').click(function(e) {
      gallery.nextPage();
      e.preventDefault();
    });
    $('a#fullScreen').click(function(e){
      alert('launch other slideshow');
      e.preventDefault();
    })

  }
})(jQuery);


$(function(){
  $('#menu').mainMenu();
  $("#thumbs").livequery(function(){
    $(this).gallery('classic');
  });
  SlideShow.setup();


});

