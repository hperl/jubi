module ApplicationHelper
  include Features

  def timeslot_title(timeslot)
    "#{l timeslot.start.to_date, format: :weekday}, #{l timeslot.start, format: :short_time} – #{l timeslot.end, format: :time}"
  end

  def accumulate(grouped_count, start)
    i = 0
    out = {}

    # insert missing data points till start
    first_date = Date.parse(grouped_count.keys.first)
    s = start
    while s < first_date
      out[s.strftime("%d.%m.%Y")] = 0
      s += 1.hour
    end

    grouped_count.keys.each { |k| out[k] = i = grouped_count[k] + i }

    # insert missing data point till now
    last_date = Date.parse(grouped_count.keys.last)
    while last_date < Time.now
      last_date += 1.hour
      out[last_date.strftime("%d.%m.%Y")] = i
    end

    # delete unwanted data points before start
    out.delete_if { |k| Date.parse(k) < start }

    out
  end

  def spaces_left_text(num)
    case num
    when Float::INFINITY
      'noch beliebig freie Plätze'
    when 0
      'keine freien Plätze mehr'
    when 1
      'noch ein freier Platz'
    else
      "noch #{num} freie Plätze"
    end
  end

  def switch_language_url(url=request.url)
    if Rails.env == 'production'
      domain_localized_uri_for(url)
    else
      params_localized_uri_for(url)
    end
  end

  private
  def domain_localized_uri_for(url)
    new_host = case I18n.locale
               when :de then '60years.yfu.de'
               else          '60jahre.yfu.de'
               end
    uri = URI(url)
    uri.host = new_host
    uri.scheme = 'https'
    return uri.to_s
  end

  def params_localized_uri_for(url)
    new_locale = case I18n.locale
                 when :de then "en"
                 when :en then "de"
                 end
    return URI(url).merge("?locale=#{new_locale}").to_s
  end

  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
    @markdown.render(content).html_safe
  end
end
