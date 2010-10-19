$.fn.htmlWithFade= function(html, speed){
  return $.each(this, function(){
    $(this).html($(html).css('opacity','hide').fadeIn(speed))  
  })
}

$(function(){

  $('form').live('submit', function(){
    $(this).find('div.ajax-loader').css('display','block')
    return true
  });

  $(".actions a, .list_buttons a, .buttons a, input:submit").livequery(function(){
    $(this).button()
  });

  //user list
  $('#users.accordion').livequery(
    function(){
      $(this).ajaxAccordion({
          header: ".header",
          collapsible: true,
          active:false,
          autoHeight: false,
          ajaxSelectors: [['form', 'submit'],['a', 'click']]
      });
    },
    function(){
      $(this).ajaxAccordion('destroy')
    }
  );

  $("#publications, #videos").livequery(function(){
    var controller_name = $(this).attr('id')
    var self = $(this);
    $(this).sortable(
      {
        axis:'y',
        forcePlaceholderSize: true,
        update: function(evt,ui){
          var $elt = $(ui.item);
          $.get('/admin/'+ controller_name +'/reorder', {
            ids: $.map($(evt.target).children(), function(sortedElt) {
                return sortedElt.id.match(/\d+/)
              }),
              position: $elt.index()+1,
              id: $elt.attr('id').match(/\d+/).toString()
            },function(data){
              var data = data;
              $.each(self.children().find('.number'), function(i,elt){
                $(elt).html("#" + data[i] )
              });
            }
          );
        }
      }
    );
  });



  // Init multipart forms to send data via iframe
  ajaxMulitipartForm.setup();

  // init the textarea to load with tinyMCE editor
  $('textarea').livequery(
    function(){
      $(this).tinymce({
        mode:'textarea',
        theme : "advanced",
        plugins : "advlink, paste",
        theme_advanced_buttons1: "bold,italic,underline,|,undo,redo,|,link,unlink,|, pastetext, pasteword, removeformat",
        theme_advanced_buttons2: '',
        theme_advanced_buttons3: '',
        theme_advanced_buttons4: '',
        theme_advanced_toolbar_location: 'top',
        removeformat_selector: 'b,strong,em,i,span,ins,ul,li,div'
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
      var self = $(this);
      $(this).sortableAccordion({
        accordion:{
          header: ".header",
          collapsible: true,
          active:false,
          autoHeight: false,
          ajaxSelectors: [['a.cancel_edit_category','click'],['.category_header a.add_picture,.category_header a.edit_category','click']]
        },
        sortable:{
          axis: "y",
          handle: ".header",
          update: function(evt,data){
            $elt = $(data.item);
            $.get('/admin/categories/reorder', {
                ids: $.map($(evt.target).children(), function(sortedElt) {
                  return sortedElt.id.match(/\d+/)
                }),
                position: $elt.index()+1,
                id: $elt.attr('id').match(/\d+/).toString()
              },function(data){
                var data = data;
                $.each(self.children().find('.header .number'), function(i,elt){
                  $(elt).html("#" + data[i] )
                });
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

  // Close the accordion tab before to send the query to the iframe
  $('form.edit_category').live('submit',function(e){
      $(this).closest(".categories").accordion('activate',-1);
      return true
  });

  //Init the sortable lists of pictures, within each category (.category)
  $('.pictures.sortable').livequery(
    function(){
      var self = $(this);
      $(this).sortable({
        axis: "y",
        forcePlaceholderSize: true,
        update:function(evt,ui){
          var $elt = $(ui.item);
          $.get('/admin/categories/' + evt.target.id.match(/\d+/) + '/pictures/reorder', {
              ids: $.map($(evt.target).children(), function(sortedElt) {
                return sortedElt.id.match(/\d+/)
              }),
              position: $elt.index()+1,
              id: $elt.attr('id').match(/\d+/).toString()
            },function(data){
              var data = data;
              $.each(self.children().find('.number'), function(i,elt){
                $(elt).html("#" + data[i] )
              });
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
  $(".ui-sortable a.delete").livequery('click', function(evt){
    evt.stopImmediatePropagation();
    evt.preventDefault();
    $link = $(this).closest('a');
    $(this).closest('.sortable_item').fadeOut(function(){
      $link.callRemote();
      $(this).remove();
      $(this).closest(".ui-sortable").sortable('refresh');
    });
  });


  $('div.top_picture').livequery(function(){
    $(this).hover(function(){
      $(this).children('.tool_box').fadeTo('fast',0.7);
    },function(){
     $(this).children('.tool_box').fadeTo('fast', 0);
    })
  })

  $('div.top_picture > div.tool_box').livequery(function(){
    $(this).hover(function(){
      $(this).fadeTo('fast',1);
    },function(){
     $(this).fadeTo('fast', 0.7);
    })
  })

});


