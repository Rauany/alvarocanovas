$(function(){

  // Init multipart forms to send data via iframe 
  ajaxMulitipartForm.setup();

  // init the textarea to load with tinyMCE editor
  $('textarea').livequery(
    function(){
      $(this).tinymce({
        mode:'textarea',
        theme : "advanced",
        plugins : "advlink",
        theme_advanced_buttons1: "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,undo,redo,|,link,unlink,anchor",
        theme_advanced_buttons2: '',
        theme_advanced_buttons3: '',
        theme_advanced_buttons4: '',
        theme_advanced_toolbar_location: 'top'
      })
    }
  );

  // Init the main admin tabs
  $("#tabs").tabs({
    fx: { height: 'toggle', opacity: 'toggle', duration: 400 }
  });

//  categories sortable accordions
  $('.categories').livequery(
    function(e){
      $(this).sortableAccordion({
        accordion:{
          header: ".header",
          collapsible: true,
          active:false,
          autoHeight: false
        },
        sortable:{
          axis: "y",
          handle: ".header",
          update: function(evt){
            $.get('/admin/categories/reorder',
              {
                ordered_ids: $.map($(evt.target).children(), function(sortedElt) {
                  return sortedElt.id.match(/\d+/)
                })
              }
            );
          }
        }
      });
    },
    function(){
      $(this).sortableAccordion('destroy');
    }
  );

  //users accordion
  $('#users').livequery(
    function(){
      $(this).accordion({
          header: ".header",
          collapsible: true,
          active:false,
          autoHeight: false
      });
    }
  );

  $("#publications").livequery(function(){
    $(this).sortable(
      {
        axis:'y',
        forcePlaceholderSize: true,
        update: function(evt,ui){
          $.get('/admin/publications/reorder',
            {
              ordered_ids: $.map($(evt.target).children(), function(li) {
                return li.id.match(/\d+/)
              })
            }
          );
        }
      }
    );
  });


  //Properly remove a header after its deletion
  $("a.delete_category").livequery('click', function(evt){
    evt.stopImmediatePropagation();
    evt.preventDefault();
    $(this).parents('.category').fadeOut(function(){
      $(evt.target).callRemote();
      $(this).remove();
      $(this).closest(".categories").sortable('refresh');
    });
  });


  //Close accodion when a header's content is updated via ajax, and then fire the ajax call
  $("a.edit_category, a.add_picture, a.cancel_edit_category").livequery('click', function(evt){
      evt.stopImmediatePropagation();
      evt.preventDefault();
      var $elt = $(this);
      var $categories = $elt.closest(".categories")
      $categories.accordion('activate',-1);
      var interval = setInterval(function(){
        if($categories.data('accordion').running == 0){
          $elt.callRemote();
          clearInterval(interval);
        }
      },200)
    });

  // Same as above for the multipart's form which don't send ajax request
  $('form.edit_category').live('submit',function(e){
      $(this).closest(".categories").accordion('activate',-1);
      return true
  });


  //Reopen an accordion header after that its content has been updated via Ajax
  // We don't apply on a.cancel_edit_category as the action sends back update.js
  $("a.edit_category, a.add_picture")
    .live('ajax:complete',function(e){
      $(this).closest(".ui-accordion").accordion('activate','#'+$(this).closest('.category').attr('id')+' .header');
    });





    //Init the sortable lists of pictures, within each category (.category)
    $('.pictures.sortable').livequery(
      function(){
        $(this).sortable({
          axis: "y",
          forcePlaceholderSize: true,
          update:function(evt,ui){
            $.get('/admin/categories/' + evt.target.id.match(/\d+/) + '/pictures/reorder',
              {
                ordered_ids: $.map($(evt.target).children(), function(li) {
                  return li.id.match(/\d+/)
                })
              }
            );
          }
        })
      },
      function(){
        $(this).sortable('destroy');
      }
    );


  //properly destroy a picture
  $("a.delete_picture").livequery('click', function(evt){
    evt.stopImmediatePropagation();
    evt.preventDefault();
    $(this).parents('.picture').fadeOut(function(){
      $(evt.target).callRemote();
      $(this).remove();
      $(this).closest(".pictures").sortable('refresh');
    });
  });


  //user list
  $('#users').livequery(
    function(){
      $(this).accordion({
          header: ".header",
          collapsible: true,
          active:false,
          autoHeight: false
      });
    }
  );



  $('#users form').livequery('submit',function(e){
    e.stopImmediatePropagation();
    e.preventDefault();
    var $elt = $(this);
    $elt.closest(".ui-accordion")
      .queue(function(){
        $(this).accordion('activate',-1);
        $(this).dequeue();
      })
      .delay(200)
      .queue(function(){
        $elt.callRemote();
        $(this).dequeue();
      });
  });

  $('#users .header a, .users form a.cancel').livequery('click',function(e){
    e.stopImmediatePropagation();
    e.preventDefault();
    var $elt = $(this);
    $elt.closest(".ui-accordion")
      .queue(function(){
        $(this).accordion('activate',-1);
        $(this).dequeue();
      })
      .delay(200)
      .queue(function(){
        $elt.callRemote();
        $(this).dequeue();
      });
  });

  $("a.edit_user,")
    .live('ajax:complete',function(e){
      $(this).closest(".users").accordion('activate','#'+$(this).closest('.user').attr('id')+' .header');
    });

});


//  // Ferme l'accordéon avant de lancer une requete Ajax, lorsque le lien déclanchant est situé dans le header de l'accordéon
//  $('.accordion .header a').livequery('click',function(e){
//    e.stopImmediatePropagation();
//    e.preventDefault();
//    var $elt = $(this);
//    $elt.closest(".accordion")
//      //replie l'accordéon
//      .queue(function(){
//        $(this).accordion('activate',-1);
//        $(this).dequeue();
//      })
//      .delay(1000)
//      //Lance la requete AJAX
//      .queue(function(){
//        $elt.callRemote();
//        // supprime l'accordeon tab si le lien est un .delete
//        if ($elt.hasClass('delete')){
//          $elt.closest('.accordion_tab').fadeOut(function(){
//            $(this).remove();
//          });
//        }
//        $(this).dequeue();
//      });
//  });
//  $('.accordion .header a').livequery('ajax:complete', function(e){
//    $(this).closest(".accordion").accordion('activate','#'+$(this).closest('.accordion_tab').attr('id')+' .header');
//  })
//
////  $('.accordion form').live('submit',function(e){
////      $(this).closest(".accordion").accordion('activate',-1);
////      return true
////  });
//
//
//  $('.accordion form').livequery('submit',function(e){
//    var $elt = $(this);
//    e.preventDefault();
//    e.stopImmediatePropagation();
//    $elt.closest(".accordion")
//      .queue(function(){
//        $(this).accordion('activate',-1);
//        $(this).dequeue();
//      })
//      .queue(function(){
//        if($elt.attr('data-remote')){
//          $elt.callRemote();
//        }
//        else{}
//
//        $(this).dequeue();
//      });
//  });



//
//