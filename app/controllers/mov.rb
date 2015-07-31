require 'imdb'

class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    i = Imdb::Movie.new(params[:movie][:imdb_id])
    @movie = Movie.new(poster: i.poster, title: i.title, upvotes: 0, downvotes: 0, imdb_id: params[:movie][:imdb_id], plot_summary: i.plot)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    vote 1
  end 

  def clearvote
    vote 0
  end
 
  def downvote
    vote -1
  end 

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:poster, :title, :upvotes, :downvotes)
    end

    def vote(type)
    if session[:user_id]
      x = Movie.find(params[:id])
      vs = Vote.where(movie_id: params[:id], user_id: session[:user_id])

      if vs.length > 0
        v = vs.first
        if v.vote_type == type then
          v.vote_type = 0
        else
          v.vote_type = type
        end
        v.save
      else
        v = Vote.new()
        v.movie = x
        v.user = User.find(session[:user_id])
        v.vote_type = type
      end
      v.save
      update_votes(x)
    end
    redirect_to action: 'index'

    end
    
    def update_votes(movie)
      votes = Vote.where(movie: movie)
      if votes.length > 0
        upvotes = 0
        downvotes = 0       
        votes.each do |vote|
          upvotes += 1 if vote.vote_type == 1
          downvotes += 1 if vote.vote_type == -1
        end
        movie.upvotes = upvotes
        movie.downvotes = downvotes
        movie.save
      end
    end
end
