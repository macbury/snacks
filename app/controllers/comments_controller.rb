class CommentsController < ApplicationController
  before_filter :login_required, :find_commentable
  
  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.user = self.current_user
    if @comment.save
      flash[:notice] = "Dodano komentarz"
    else
      flash[:error] = "Nie można dodać komentarza"
    end
    
    respond_to do |format|
      format.html { redirect_to @commentable }
      format.js
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy if own?(@comment)
    
    flash[:notice] = "Komentarz został usunięty."
    
    respond_to do |format|
      format.html { redirect_to @commentable }
      format.js { render :nothing => true }
    end
  end
  
  protected 
  
  def find_commentable
    params.each do |name, value|
      if name != "school_id" && name =~ /(.+)_id$/
        klass = $1.classify.constantize
        
        if klass.respond_to?(:find_by_permalink)
          @commentable = klass.find_by_permalink(value)
        else
          @commentagle = klass.find(value)
        end

      end
    end
    
    render :file => "#{RAILS_ROOT}/public/404.html" if @commentable.nil?
  end
  
end
