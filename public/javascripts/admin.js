$.fn.htmlWithFade= function(html, speed){
  return $.each(this, function(){
    $(this).html($(html).css('opacity','hide').fadeIn(speed))  
  })
}

$(function(){

  //user list
  $('#users').livequery(
    function(){
      $(this).ajaxAccordion({
          header: ".header",
          collapsible: true,
          active:false,
          autoHeight: false
      });
    },
    function(){
      $(this).ajaxAccordion('destroy')
    }
  );

  $("#publications, #videos").livequery(function(){
    var controller_name = $(this).attr('id')
    $(this).sortable(
      {
        axis:'y',
        forcePlaceholderSize: true,
        update: function(evt,ui){
          $.get('/admin/'+ controller_name +'/reorder',
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



  // Init multipart forms to send data via iframe
  ajaxMulitipartForm.setup();

  // init the textarea to load with tinyMCE editor
  $('textarea').livequery(
    function(){
      $(this).tinymce({
        mode:'textarea',
        theme : "advanced",
        plugins : "advlink",
        theme_advanced_buttons1: "bold,italic,underline,strikethrough,|,undo,redo,|,link,unlink,anchor",
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
          autoHeight: false,
          ajaxSelectors: [['div > .header a','click']]
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

  // Close the accordion tab before to send the query to the iframe
  $('form.edit_category').live('submit',function(e){
      $(this).closest(".categories").accordion('activate',-1);
      return true
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


  

});


