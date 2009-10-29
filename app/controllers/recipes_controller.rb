class RecipesController < ApplicationController
  title "lista"
  before_filter :login_required, :except => [:show, :index]
  # GET /recipes
  # GET /recipes.xml
  def index
    query = Recipe.search
    
    order = 'recipes.title ASC'
    group = 'recipes.id'
    select = 'recipes.*'
    
    if params[:ingredients]
      @tags = params[:ingredients].split(',').map { |ingredient| ingredient.strip }

      query.tags_name_like_any(@tags)
      order = 'tag_count DESC'
      
      select = '`recipes`.*, count(taggings.taggable_id) AS tag_count,(Select count(id) From taggings Where taggings.taggable_id = recipes.id) as tag_total'
      group = 'recipes.id HAVING ROUND(tag_count * 100 / tag_total) >= 30'
      
    end
    
    @recipes = query.paginate(  :select => select,
                                :include => [:user, :tags],
                                :per_page => 10, 
                                :page => params[:page], 
                                :group => group,
                                :order => order )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipes }
    end
  end

  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    @recipe = Recipe.find_by_permalink(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/new
  # GET /recipes/new.xml
  def new
    @recipe = Recipe.new

    respond_to do |format|
      format.html { render :action => "form" }
      format.xml  { render :xml => @recipe }
    end
  end

  # GET /recipes/1/edit
  def edit
    @recipe = self.current_user.recipes.find_by_permalink(params[:id])
    render :action => "form"
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = self.current_user.recipes.new(params[:recipe])

    respond_to do |format|
      if @recipe.save
        flash[:notice] = 'Przepis został dodany!'
        format.html { redirect_to(@recipe) }
        format.xml  { render :xml => @recipe, :status => :created, :location => @recipe }
      else
        format.html { render :action => "form" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recipes/1
  # PUT /recipes/1.xml
  def update
    @recipe = self.current_user.recipes.find_by_permalink(params[:id])

    respond_to do |format|
      if @recipe.update_attributes(params[:recipe])
        flash[:notice] = 'Recipe was successfully updated.'
        format.html { redirect_to(@recipe) }
        format.xml  { head :ok }
      else
        format.html { render :action => "form" }
        format.xml  { render :xml => @recipe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.xml
  def destroy
    @recipe = self.current_user.recipes.find_by_permalink(params[:id])
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to(recipes_url) }
      format.xml  { head :ok }
    end
  end
end
