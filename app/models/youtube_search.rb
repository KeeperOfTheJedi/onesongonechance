require 'google/api_client'

class YoutubeSearch
  # Please use your own API key and enable the Youtube API for it
  # This default key is provided for your convenience but it will be invalid soon
  # On Heroku, you can set `heroku config:set GOOGLE_API_KEY=your-key-value
  # On localhost, you can set the GOOGLE_API_KEY ENV variable or use the dotenv gem
  DEVELOPER_KEY = ENV['GOOGLE_API_KEY'] || 'AIzaSyD4-KUNQ2O9Y8aguY6KUNrMrVlljvPOVO8'
  YOUTUBE_API_SERVICE_NAME = 'youtube'
  YOUTUBE_API_VERSION = 'v3'

  # allows other classes to access the variables youtube, client, etc JUN
  attr_reader :youtube, :client, :videos, :playlists, :channels

  # YoutubeSearch.new runs whatever is in get_service 
  def initialize
    get_service
  end

  def get_service
    #creates a new Google API client named @client (JUN)
    #@youtube runs the discovered_api in @client based on serice and api names (JUN)
    @client = Google::APIClient.new(
      :key => DEVELOPER_KEY,
      :authorization => nil,
      :application_name => $PROGRAM_NAME,
      :application_version => '1.0.0'
    )
    @youtube = @client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

    return @client, @youtube
  end

  # return a list of Result instances
  # runs a local or network search with name query on YoutubeSearch which is supposed to be running the Youtube API via Google client
  def self.search(query)
    results = self.local_search(query) 
    if results.empty?
      self.network_search(query)
    else
      results
    end
  end
   def self.get_video_info_by_url(videoid)
    videorespon = Net::HTTP.get(URI.parse("https://www.googleapis.com/youtube/v3/videos?id=" + videoid + "&part=contentDetails&key=AIzaSyD4-KUNQ2O9Y8aguY6KUNrMrVlljvPOVO8"))
    data_json= JSON.parse videorespon
    data_duration = data_json["items"][0]["contentDetails"]["duration"]
    time_duration = YoutubeSearch.convertvideolength(data_duration)
    
    return time_duration
  end
  def self.convertvideolength(iso8601)
    ret = 100;
    minute = "";
    second = 0;
    iso8601 = iso8601.gsub('PT', '')
      if(iso8601["M"])
        minute = iso8601.split('M')[0];
        if(iso8601["S"])
          second = iso8601.gsub('S', '').gsub(minute + 'M', '')
        end
      else
        minute = 0
        if(iso8601["S"])
          second = iso8601.gsub('S', '')
        end
      end
       return ret = minute.to_i*60 + second.to_i
       
       
  end
  # network search runs a youtube_search 
  def self.network_search(query)
    instance = new
    instance.youtube_search(query)
  end

  def youtube_search(query)
    @search = {}
    return @search[query] if @search[query] # what is this for? (JUN)

    # runs the search on the Youtube Search client as search_response 
    search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => {
        :part => 'snippet',
        :q => query,
        :maxResults => max_result,
      }
    )

    # puts the search_response in items and puts creates a Result record for each result and puts them in a results array  
    results = []
    items = search_response.data.items
    items.each do |search_result|
      results << Result.create!(query: query, raw: search_result.as_json)
    end
    @search[query] = results
  end

  def self.local_search(query)
    Result.where(query: query)
  end

  def max_result
    25
  end
end
