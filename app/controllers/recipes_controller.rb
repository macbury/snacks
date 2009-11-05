class RecipesController < ApplicationController
  title "lista"
  add_breadcrumb 'Przepisy', 'recipes_path(:page => params[:page], :sort => params[:sort])'
  add_breadcrumb 'Nowy przepis', '', :only => [:create, :new]
  
  before_filter :login_required, :except => [:show, :index, :feed]
  
  PER_PAGE = 10
  
  # GET /recipes
  # GET /recipes.xml
  def index
    @query = Recipe.search
    
    if params[:ingredients] && !params[:ingredients].empty?
      @tags = params[:ingredients].split(',').map { |ingredient| ingredient.strip }
      @query.tags_name_equals(@tags)
      
      @select = 'distinct recipes.*, ((Select count(*) FROM taggings WHERE taggings.taggable_id = recipes.id) - count(taggings.taggable_id)) as tag_order'
      
      @group = Recipe.group + ' ' + 'HAVING (count(taggings.taggable_id) * 100) / (Select count(*) FROM taggings WHERE taggings.taggable_id = recipes.id) > 50 '
      
      add_breadcrumb 'Szukaj według składników'
    elsif params[:ingredient]
      add_breadcrumb "Składnik", 'ingredients_path'
      add_breadcrumb params[:ingredient]
      @query.tags_name_like_any(params[:ingredient])
    end

    if params[:sort].nil?
      @sort_type = @tags.nil? ? 'name' : 'revelance'
    else
      @sort_type = params[:sort]
    end
    
    #, 
    
    @recipes = @query.paginate( :select => @select, 
                                :per_page => PER_PAGE, 
                                :page => params[:page], 
                                :include => [:tags, :user], 
                                :group => @group,
                                :order => get_sort )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recipes }
    end
  end
  
  def feed
    @recipes = Recipe.all(:order => 'created_at DESC', :include => [:tags], :limit => 20)
    
    respond_to do |format|
      format.rss
    end
  end
  
  def favorites
    add_breadcrumb 'Moje ulubione przepisy'
    
    @recipes = self.current_user.favorites_recipes.paginate(
                                :include => [:user, :tags],
                                :per_page => PER_PAGE, 
                                :page => params[:page],
                                :order => get_sort )
    
    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @recipes }
    end
  end
  
  def my
    add_breadcrumb 'Moje przepisy' 
    @recipes = self.current_user.recipes.paginate(
                                :include => [:user, :tags],
                                :per_page => PER_PAGE, 
                                :page => params[:page],
                                :order => get_sort )

    respond_to do |format|
      format.html { render :action => "index" }
      format.xml  { render :xml => @recipes }
    end
  end
  
  # GET /recipes/1
  # GET /recipes/1.xml
  def show
    @recipe = Recipe.find_by_permalink(params[:id])
    @comments = @recipe.comments.all(:order => 'created_at ASC', :include => [:user])
    @title = @recipe.title
    
    add_breadcrumb 'Szukaj według składników', recipes_path(:page => params[:page], :sort => params[:sort], :ingredients => params[:ingredients]) if params[:ingredients]
      
    add_breadcrumb @recipe.title
    
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
    add_breadcrumb @recipe.title, @recipe
    add_breadcrumb 'Edycja przepisu', ''
    
    render :action => "form"
  end

  # POST /recipes
  # POST /recipes.xml
  def create
    @recipe = self.current_user.recipes.new(params[:recipe])

    respond_to do |format|
      if @recipe.save
        Blip.create :body => "#przepisy #{@recipe.title} - #{recipe_url(@recipe)}"
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
    add_breadcrumb @recipe.title, @recipe
    add_breadcrumb 'Edycja przepisu', ''
    
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
  
  protected

    def get_sort
      sortSQL = String.new
      
      sort_by = params[:sort]
      
      if sort_by.nil?
        sort_by = @tags.nil? ? 'name' : 'revelance'
      end
      
      case sort_by
        when 'name' : sortSQL = 'recipes.title ASC'
        when 'rated': sortSQL = 'recipes.favorites_count DESC' 
        when 'date': sortSQL = 'recipes.created_at DESC'
        when 'random': sortSQL = 'RANDOM()'
        when 'revelance': sortSQL = 'tag_order ASC'
      end

      return sortSQL
    end
end
