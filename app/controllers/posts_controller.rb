class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  # GET /posts or /posts.json
  def index
    @posts = Post.where('expire > ?', Date.today)
    @visits = Visit.where('user = ?', current_user.id)

    @posts.each do |post|
        @visitsAux = @visits.where('post_id_id = ?', post.id)
        if @visitsAux.empty?
          post.seen = 'No visto'
          post.save
        else 
          post.seen = 'Visto'
          post.save
        end
    end
   
    #@posts = Post.paginate(page: params[:page])
  end

  # GET /posts/1 or /posts/1.json
  def show
    if @post.seen == 'No visto'
       @visit = Visit.new(visit_params)
       @visit.email = current_user.email
       @visit.post_id_id = @post.id 
       @visit.user = current_user.id
       @post.seen = 'Visto'
       @visit.save
    end
    @post.save
  end

  # GET /posts/new
  def new
    @post = Post.new
  end
  
   def list_by_id
        @visits = Visit.all()
       
   end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    
     @post.seen = 'No visto'
     @post.owner_id = current_user.id
    

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def list_my_post
    @visits = Visit.where('email = ?', current_user.email)
    @posts = Post.where('owner_id = ?', current_user.id)
  end
  
   def list_by_seen
        @posts_filter = Post.where("seen = ?", "No visto").where('owner_id != ?', current_user.id) 
    end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.seen == '0'
          @post.seen = 'No visto'
    else
         @post.seen = 'Visto'
    end
     
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
   
    @visits = Visit.where('post_id_id = ?', @post.id)
    
    @visits.each do |visit|
      visit.destroy
    end
    @post.destroy
    respond_to do |format|
      format.html { redirect_to list_my_post_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end
    
    def visit_params
      params.permit(:email,:post_id_id)
    end

    # Only allow a list of trusted parameters through.
    def post_params
      
      params.require(:post).permit(:content, :expire, :seen)
    end
end
