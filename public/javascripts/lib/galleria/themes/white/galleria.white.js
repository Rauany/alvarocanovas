/*!
 * Galleria Classic Theme
 * http://galleria.aino.se
 *
 * Copyright (c) 2010, Aino
 * Licensed under the MIT license.
 */

(function($) {

Galleria.addTheme({
    name: 'white',
    author: 'Itkin',
    version: '1.2',
    css: 'galleria.white.css',
    defaults: {
        show_caption: false,
        image_crop: 'height',
        thumb_crop: 'height',
        autoplay: 6000,
        debug: true,
        image_position: 'center right',
        show_info: false,
        show_counter: false,
        transition: 'none',
        transition_speed: 1000,
        image_margin: 0,
        thumbnails: true


    },
    init: function(options) {
        var self = this;

        // center the images on full screeen mode
        this.exitFullscreen = function() {
          this.options['image_position']= 'center right';
          this.fullscreen.exit.apply(this, arguments);
          return this;
        };

        this.enterFullscreen = function() {
          this.options['image_position']= 'center';
          this.fullscreen.enter.apply(this, arguments);
          return this;
        };


        // add controls outside the container
        $('<a href="#">Pause</a>').appendTo("#galleria_controls").toggle(function(e){
          e.preventDefault();
          self.pause();
          $(this).html('Play');
        }, function(e){
          e.preventDefault();
          self.play();
          $(this).html('Pause');
        });

        // add fullscreen link
        $('<a href="#">Full Screen</a>').appendTo('#galleria_fullscreen').bind('click',function(e){
          e.preventDefault();
          self.enterFullscreen()
        });

        // Update caption container when a new image is shown
        this.bind(Galleria.IMAGE, function(e){
          $('#galleria_caption').html(e.index + 1 + '/' + self.data.length )
        });


        // add thumbnails-tab
        if (this.options['thumbnails']){
          this.addElement('thumbnails-tab');
          this.appendChild('thumbnails-container','thumbnails-tab');

          var tab = this.$('thumbnails-tab');
          tab.append('<span>THUMBS</span>')

          this.$('thumbnails-container').hover(
            function(){
              $(this).clearQueue();
              $(this).queue(function(){
                tab
                .animate({height:"2px"})
                .find('span')
                .fadeOut('fast');
                $(this).dequeue();
              })
            },
            function(){
              $(this).delay(1500);
              $(this).queue(function(){
                tab
                .animate({height:"45px"})
                .find('span')
                .fadeIn('slow');
                $(this).dequeue();
              })
            }
          );
        } else {
          this.$('thumb-nav-left,thumb-nav-right').hide();
        }



        this.addElement('info-link','info-close');
        this.append({
            'info' : ['info-link','info-close']
        });
        
        this.$('loader').show().fadeTo(200, .4);
        this.$('counter').show().fadeTo(200, .4);
        
        this.$('thumbnails').children().hover(function() {
            $(this).not('.active').children().stop().fadeTo(100, 1);
        }, function() {
            $(this).not('.active').children().stop().fadeTo(400, .4);
        }).not('.active').children().css('opacity',.4);


        // show image nav when hovering the image
        if (this.data.length >= 2) {
          this.$('stage').hover(this.proxy(function() {
              this.$('image-nav-left,image-nav-right,counter').fadeIn(200);
          }), this.proxy(function() {
              this.$('image-nav-left,image-nav-right,counter').fadeOut(500);
          }));
        }

        this.$('image-nav-left,image-nav-right,counter').hide();
        
        var elms = this.$('info-link,info-close,info-text').click(function() {
            elms.toggle();
        });
        
        if (options.show_caption) {
            elms.trigger('click');
        }
        
        this.bind(Galleria.LOADSTART, function(e) {
            if (!e.cached) {
                this.$('loader').show().fadeTo(200, .4);
            }
            if (this.hasInfo()) {
                this.$('info').show();
            } else {
                this.$('info').hide();
            }
        });

        this.bind(Galleria.LOADFINISH, function(e) {
            this.$('loader').fadeOut(200);
        });
        this.bind(Galleria.LOADSTART, function(e) {
            $(e.thumbTarget).css('opacity',1).parent().addClass('active')
                .siblings('.active').removeClass('active').children().css('opacity',.4);
        })
    }
});

})(jQuery);