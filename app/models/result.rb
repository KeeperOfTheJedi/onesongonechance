class Result < ActiveRecord::Base
  validates :query, :raw, presence: true

  def kind
    raw["id"]["kind"]
  end

  def result_type
    case kind
    when "youtube#video" then 'Video'
    when "youtube#channel" then 'Channel'
    when "youtube#playlist" then 'Playlist'
    else "Unknown: #{kind}"
    end
  end

  def video_id
    raw["id"]["videoId"]
  end

  def snippet
    raw["snippet"]
  end

  def description
    snippet["description"]
  end

  def title
    snippet["title"]
  end

  def thumbnails
    snippet["thumbnails"]
  end

  def default_thumbnail
    thumbnails["default"]
  end

  def default_thumbnail_url
    default_thumbnail["url"]
  end

  def default_thumbnail_width
    default_thumbnail["width"]
  end

  def default_thumbnail_height
    default_thumbnail["height"]
  end

  def video?
    kind == "youtube#video"
  end
end
