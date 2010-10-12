class Admin::ContentsController < Admin::ApplicationController
  layout false
  
  def edit
    @content = Content.find(params[:id])
    render :action => :edit
  end

  def update
    @content = Content.find(params[:id])
    if @content.update_attributes(params[:content])
      flash.now[:notice] = "Contenu dynamique mis à jour avec succès"
      responds_to_parent { render :action => 'update.js.erb' }
    else
      flash.now[:notice] = "Echec de la mise a jour du contenu dynamque"
      responds_to_parent { render :action => 'edit.js.erb' }
    end
  end

  def edit_contact_page
    @contact = Content::CONTACT
    @links =   Content::LINKS
  end

  def update_contact_page
    @contact = Content::CONTACT
    @links =   Content::LINKS
    @contact.update_attributes(params[:contact]) and @links.update_attributes(params[:links])
  end

end
