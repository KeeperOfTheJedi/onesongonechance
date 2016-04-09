module UsersHelper
  def flash_class_name(key)
    case key.to_s
    when "success"
      "alert-success"
    when "info"
      "alert-info"
    when "error"
      "alert-danger"
    else
      "alert-warning"
    end
  end
end