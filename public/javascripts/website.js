
$.fn.htmlWithFade= function(html, fade_out_speed,fade_in_speed ){
  var fade_out_speed = fade_out_speed || 'slow';
  var fade_in_speed = fade_in_speed || 'fast';
  return $.each(this, function(){
    $(this).fadeOut(fade_out_speed,function(){
      $(this).html(html).fadeIn(fade_in_speed)
    });
  })
}

$.fn.replaceWithFade=function(html,fade_out_speed,fade_in_speed){
  var fade_out_speed = fade_out_speed || 'slow',
      fade_in_speed = fade_in_speed || 'fast',
      html = html ;
  return $.each(this, function(){
    $wrapper = $(this).wrap('<div class="wrapper"></div>').parent();
    $wrapper.fadeOut(fade_out_speed, function(){
      $(this).html(html)
    }).fadeIn(fade_in_speed,function(){
      $(this).children().unwrap()
    });
  })

}

var menuTimeout, sideMenuTimeout, ThumbsTimeout;

$(function(){

  // Initialisation menu principal
  $('#menu h2').css('width',$('#main_menu_list').width()-10 + 'px');
  $('#menu li.first_level').fadeTo(1,0);
  $('#menu').hover(
    function(){
      $(this)
        .clearQueue()
        .queue(function(){
          $this = $(this);
          $this
            .find('h2').animate({top: "60px"}, function(){
              $('#menu ul.sub_items').css('borderTop', '1px solid');
            })
            .find('span').fadeOut(100);
          $this
            .find('li.first_level')
            .fadeTo(200,1);
          $this.dequeue();
        });
    },
    function(){
     $(this)
      .delay(2000)
      .queue(function(){
        $('#menu ul.sub_items').css('borderTop', 'none');
        $(this)
          .find('h2').animate({top: "20px"})
          .find('span').fadeIn(100);
        $(this)
          .find('li.first_level')
          .fadeTo(200,0);
        $(this).dequeue()
      })
    }
  );


  $('#menu ul ul').hide();
  // Sous menus du menu principal
  $("#menu li.first_level").hover(
    function(){
      $(this).find('ul').fadeIn('fast')
    },
    function(){
      $(this).find('ul').fadeOut('fast')
    }
  );



  // Accès direct a une gallery depuis la page categories/:id/show
  $('.category_pictures').live('click',function(){
    $('#content').clearQueue();
  });

  // Initialization du sous menu des categories
  $('.category.menu, #publications.menu').livequery(
    function(){
      $(this).find('ul').css('display','none');
      $(this).hover(
        function(){
          $(this).clearQueue();
          $(this).queue(function(){
            $(this).find('ul').slideDown();
            $(this).dequeue();
          });
        },
        function(){
          $(this)
            .delay(2000)
            .queue(function(){
              $(this).find('ul').slideUp();
              $(this).dequeue();
            })
        }
      );
    }
  );

    $('#gallery').livequery(function(){
      if ($(this).hasClass('videos')){
        var thumb = ( $(this).children('img').length >= 2 ) ? true : false;
        var video_gallery = $(this).galleria({thumbnails: thumb, autoplay: false, carousel: false });
        video_gallery.bind(Galleria.IMAGE, function(e){
          if (!e.index == 0){
            var video_id = $(e.imageTarget).attr('id');
            $.ajax({method: 'GET', url: 'videos/'+ video_id,dataType: 'script'})
          }
        });
      }
      else if ($(this).hasClass('categories') || $(this).children('img').length < 2)
        $(this).galleria({thumbnails: false });
      else
        $(this).galleria({thumbnails: true});
    },function(){
      Galleria.get(Galleria.get().length-1).pause()
    });

    // Show image nav when the payer is hovered
    $('.vimeo_player').livequery(function(){
      $(this).hover(function(){
         $('#gallery').find('div.galleria-image-nav-left,div.galleria-image-nav-right').fadeIn(200);
      }, function(){
         $('#gallery').find('div.galleria-image-nav-left,div.galleria-image-nav-right').fadeOut(500);
      });
    });
//  // Initilisation des galleries
//  $("#gallery.categories #thumbs, #gallery.pictures #thumbs, #gallery.publications #thumbs").livequery(function(){
//    $(this).gallery('classic',{ autoStart: ($(this).find('img').size() > 1) ? true : false });
//  });
//
//  $("#gallery.videos #thumbs").livequery(function(){
//    $(this).gallery('classic',{
//      autoStart: false,
//      onSlideChange:function(previousIndex,nextIndex){
//        if (previousIndex != nextIndex){
//          video_id = $('ul.thumbs').children().eq(nextIndex).find('img').attr('id')
//          $.ajax({method: 'GET', url: 'videos/'+ video_id,dataType: 'script'})
//        }
//      }
//    });



//
//  });

  $('form input, form textarea').livequery(function(){
    if ($(this).attr('id') !="send_message"){
      $(this).focus(function(){
        $(this).css('backgroundColor','#bdbbbb')
      },function(){
        $(this).css('backgroundColor','#e5e1e1')
      })
    }
  });

  $("#send_message").livequery(function(){
    $(this).hover(function(){
      $(this).css('backgroundImage','url("/images/mail_hover.png")')
    },function(){
      $(this).css('backgroundImage','url("/images/mail.png")')
    })
  })




  //$('#menu a').address()
//  $.address.change(function(event) {
//    $.getScript(event.value);
//  });
// $('#menu a').click(function() {
//   $.address.value($(this).attr('href'));
// });

});

