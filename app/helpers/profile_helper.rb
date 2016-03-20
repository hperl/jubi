#encoding: utf-8
module ProfileHelper
  def checkin_checkout_interval(r)
    "#{t r.estimated_checkin_day} (#{t r.estimated_checkin_time}) – " +
      "#{t r.estimated_checkout_day} ( #{t r.estimated_checkout_time})"
  end

  def checkin_text(r)
    "#{t r.estimated_checkin_day} (#{t r.estimated_checkin_time})"
  end

  def checkout_text(r)
    "#{t r.estimated_checkout_day} (#{t r.estimated_checkout_time})"
  end

  def enum_radio_buttons(form, enum_field, options = {})
    if block_given?
      enums = ConferenceRegistration.send(enum_field.to_s.pluralize).map {|e| [e.first, yield(e.first)]}
    else
      enums = ConferenceRegistration.send(enum_field.to_s.pluralize).map {|e| [e.first, t(e.first)]}
    end
    form.collection_radio_buttons(enum_field, enums, :first, :last, options)
  end

  # returns a representation of offered help for a registration
  def help_offered(r)
    res = []
    ConferenceRegistration::HELP_AREAS.each do |area|
      if r.send("wants_to_help_#{area}")
        res << t(area)
      end
    end
    res << "Workshop anbieten" if r.wants_to_offer_workshop
    return res.join(', ')
  end

  def transaction_description(transaction)
    if transaction.class == Payment
      return "Einzahlung"
    elsif transaction.class == ConferenceRegistration
      if transaction.state == 'cancelled' || transaction.state == 'cancelled_without_costs'
        title = 'Stornierte BUT-Anmeldung'
      else
        title = 'BUT-Anmeldung'
      end
      return "#{title}<br>(#{pluralize(transaction.days, 'Tag', 'Tage')} im #{t(transaction.accomodation)})".html_safe
    else
      return ""
    end
  end
end
