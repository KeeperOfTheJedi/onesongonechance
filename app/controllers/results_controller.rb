class ResultsController < ApplicationController
  
  # passes q from view into Youtube.search (JUN)
  def index
    if query = params[:q]
      @results = YoutubeSearch.search query
    end
  end
end
