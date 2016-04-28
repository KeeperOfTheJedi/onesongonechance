class ResultsController < ApplicationController

  # passes q from view into Youtube.search (JUN)
  def index
  	if query = params[:q]
  		@results = YoutubeSearch.search query
  	end
  end
  def searhsong
  	query = params[:q]
  	@results = YoutubeSearch.search query
  	respon_string = ""
  	


  	if @results.present? 
  		@results.each do |result| 
  			if result.video? 


  				if result.result_type == "Video" 
  					respon_string = respon_string +
  					"<div class='search-song-result' id=" + result.video_id + " onclick=add_song_to_list(this.id)>"+
  					"<div class='row result-card'>"+
  					"<div class='yt-thumbnail'>"+
  					"<img src=" + result.default_thumbnail_url  +
  					
  					"></div>"+
  					"<div class='result-title'>"+
  					result.title+
  					"</div>"+
  					"</div></div>"
  				end

  			end
  		end 
  	end
  	respond_to do |format|   	
  		result_respon = { :status => "ok", :message => "Success!", :html => respon_string  }				
  		format.json  { render :json => result_respon } 
  	end	
  end
end
