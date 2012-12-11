module ApplicationHelper

  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    else
      attributes["style"] = "display: block"
    end
    content_tag("div", attributes, &block)
  end

  def hidden_ul_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    else
      attributes["style"] = "display: block"
    end
    content_tag("ul", attributes, &block)
  end

  def twitterized_type(type)
    case type
      when :alert
        "alert-block"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        type.to_s
    end
  end

end
