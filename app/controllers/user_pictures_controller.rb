class UserPicturesController < ApplicationController
  before_action :set_user_picture, only: [:show, :edit, :update, :destroy, :choosing, :pick]

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

  # GET /user_pictures_choosing/1/970813166333212
  def choosing
    @photos = current_user.fb_photos(params[:album_id])
  end

  # GET /user_pictures_pick/1/970813166333212
  def pick
    @photo = current_user.fb_photo(params[:photo_id])
  end


  # PATCH/PUT /user_pictures/1
  # PATCH/PUT /user_pictures/1.json
  def update
    @photo = current_user.fb_photo(params[:photo_id])
    if @user_picture.update(:picture_metas => @photo)
      flash[:success] = "The chosen picture has been added to your profile"
    else
      flash[:success] = "Somewhere something went wrong. Sorry!"
    end
    redirect_to my_profile_path(section: 'picture')
  end

  # DELETE /user_pictures/1
  # DELETE /user_pictures/1.json
  def destroy
    if @user_picture.update(:picture_metas => nil)
      flash[:success] = "The chosen picture has been detached from your profile"
    else
      flash[:success] = "Somewhere something went wrong. Sorry!"
    end
    redirect_to my_profile_path(section: 'picture')
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
