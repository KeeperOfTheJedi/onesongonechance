module UsersHelper
  def flash_class_name(key)
    case key.to_s
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      else
        "alert-warning"
      end
  end
end
