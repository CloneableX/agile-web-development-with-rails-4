module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def localized_currency(number)
    exchange = number
    unless I18n.locale == I18n.default_locale
      exchange = number * 0.82
    end
    number_to_currency(exchange)
  end
end
