class UserPicturesController < ApplicationController
  before_action :set_user_picture, only: [:show, :edit, :update, :destroy]

  # GET /user_pictures
  # GET /user_pictures.json
  def index
    @user_pictures = UserPicture.all
  end

  # GET /user_pictures/1
  # GET /user_pictures/1.json
  def show
  end

  # GET /user_pictures/new
  def new
    @user_picture = UserPicture.new
  end

  # GET /user_pictures/1/edit
  def edit
    @albums = current_user.fb_albums
  end

    # GET /user_pictures_choose/1/970813166333212
  def choose
    @photos = current_user.fb_photos(params[:album_id])
  end

  # POST /user_pictures
  # POST /user_pictures.json
  def create
    @user_picture = UserPicture.new(user_picture_params)

    respond_to do |format|
      if @user_picture.save
        format.html { redirect_to @user_picture, notice: 'User picture was successfully created.' }
        format.json { render :show, status: :created, location: @user_picture }
      else
        format.html { render :new }
        format.json { render json: @user_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_pictures/1
  # PATCH/PUT /user_pictures/1.json
  def update
    respond_to do |format|
      if @user_picture.update(user_picture_params)
        format.html { redirect_to @user_picture, notice: 'User picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_picture }
      else
        format.html { render :edit }
        format.json { render json: @user_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_pictures/1
  # DELETE /user_pictures/1.json
  def destroy
    @user_picture.destroy
    respond_to do |format|
      format.html { redirect_to user_pictures_url, notice: 'User picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_picture
      @user_picture = UserPicture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_picture_params
      params.fetch(:user_picture, {})
    end
end
