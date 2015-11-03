class ButBoard::ButBoardController < ButBoard::ApplicationController
  def show
    @users_count         = User.count
    @registrations_count = ButRegistration.payed.count + ButRegistration.unpayed.count
    @workshops_count     = Workshop.regular.count
    @helpers_count       = ButRegistration.where(
      ButRegistration::HELP_AREAS.map {|a| "wants_to_help_#{a} = 't'"}.join(' OR ')
    ).count
  end

  def workshops
    @workshops = Workshop.regular.order(:title)
  end

  # download an excel table
  def download
    excelfile = StringIO.new
    book = Spreadsheet::Workbook.new

    bold = Spreadsheet::Format.new(:weight => :bold)

    registrations = book.create_worksheet
    registrations.name = 'Anmeldungen'
    registrations.row(0).default_format = bold
    registrations.row(0).concat ['ID', 'Zuletzt geändert', 'Name', 'Spitzname', 'Landesgruppe', 'E-Mail', 'Adresse', 'Alter', 'T-Shirt', 'Essen', 'Anreise', 'Abreise', 'Verkehrsmittel', 'Nächte', 'Zimmer', 'Zimmernachbarn', 'Kosten (€)', 'Status', 'Karma', 'Kommentar', 'Freestyler', 'Checkin', 'Party', 'Kiosk', 'Will WS anbieten', 'bietet WS an']
    ButRegistration.all.each.with_index(1) do |reg, i|
      registrations.update_row i,
        reg.id,
        reg.updated_at,
        reg.name,
        reg.nickname,
        reg.lg,
        reg.user.email,
        reg.address,
        reg.age,
        reg.t_shirt_size,
        reg.diet == 'other_diet' ? reg.diet_other : t(reg.diet),
        checkin_text(reg),
        checkout_text(reg),
        I18n.t(reg.transportation),
        reg.days-1,
        I18n.t(reg.accomodation),
        reg.room_mates_text,
        reg.price,
        t(reg.state),
        reg.karma,
        reg.comment,
        reg.wants_to_help_freestyler ? 'ja' : '',
        reg.wants_to_help_checkin ? 'ja' : '',
        reg.wants_to_help_party ? 'ja' : '',
        reg.wants_to_help_kiosk ? 'ja' : '',
        reg.wants_to_offer_workshop ? 'ja' : '',
        reg.user.workshops.count != 0 ? 'ja' : ''
    end

    users = book.create_worksheet
    users.name = 'Benutzer'
    users.row(0).default_format = bold
    users.row(0).concat %w(ID E-Mail Anmeldungen Kontostand)
    User.all.each.with_index(1) do |user, i|
      users.update_row i, user.id, user.email, user.registrations.size, user.balance
    end

    workshops = book.create_worksheet
    workshops.name = 'Workshops'
    workshops.row(0).default_format = bold
    workshops.row(0).concat %w(ID zuletzt_geändert Titel Beschreibung Dauer MaxTN Trainer Anforderungen Materialien Kosten Erstwahlen Zweitwahlen Drittwahlen)
    Workshop.regular.each.with_index(1) do |ws, i|
      workshops.update_row i, ws.id,
        ws.updated_at,
        ws.title,
        ws.description,
        ws.timeframe,
        ws.max_tn,
        ws.human_trainers,
        ws.special_requirements || 'keine',
        ws.materials || 'keine',
        ws.price || '0,00',
        ws.workshop_choices.choice.first_choice.count,
        ws.workshop_choices.choice.second_choice.count,
        ws.workshop_choices.choice.third_choice.count
    end

    payments = book.create_worksheet
    payments.name = 'Zahlungen'
    payments.row(0).default_format = bold
    payments.row(0).concat %w(ID Empfänger Betrag Datum ausgeführt)
    Payment.all.each.with_index(1) do |payment, i|
      payments.update_row i,
        payment.id,
        payment.user.displayname,
        payment.amount,
        payment.created_at,
        payment.responsible_user.displayname
    end

    but_plans = book.create_worksheet
    but_plans.name = 'Workshop-Einteilungen'
    header = %w(ID Name)
    Timeslot.workshop.order({start: :asc, end: :asc}).each do |ts|
      header << "#{I18n.l(ts.start.to_date, format: :weekday)} #{I18n.l(ts.start, format: :short_time)} 1. Wahl"
      header << "#{I18n.l(ts.start.to_date, format: :weekday)} #{I18n.l(ts.start, format: :short_time)} 2. Wahl"
      header << "#{I18n.l(ts.start.to_date, format: :weekday)} #{I18n.l(ts.start, format: :short_time)} 3. Wahl"
      header << "#{I18n.l(ts.start.to_date, format: :weekday)} #{I18n.l(ts.start, format: :short_time)} Eingeteilt"
    end
    but_plans.row(0).default_format = bold
    but_plans.row(0).concat header

    ButRegistration.payed.each.with_index(1) do |r, i|
      row = [r.id, r.name]
      Timeslot.workshop.order({start: :asc, end: :asc}).each do |ts|
        row << Workshop.joins(:workshop_choices, :timeslots).where(timeslots: {id: ts.id}, workshop_choices: { final: false, choice_type: WorkshopChoice.choice_types["first_choice"], but_registration: r}).first.try(:title)
        row << Workshop.joins(:workshop_choices, :timeslots).where(timeslots: {id: ts.id}, workshop_choices: { final: false, choice_type: WorkshopChoice.choice_types["second_choice"], but_registration: r}).first.try(:title)
        row << Workshop.joins(:workshop_choices, :timeslots).where(timeslots: {id: ts.id}, workshop_choices: { final: false, choice_type: WorkshopChoice.choice_types["third_choice"], but_registration: r}).first.try(:title)
        row << Workshop.joins(:workshop_choices, :timeslots).where(timeslots: {id: ts.id}, workshop_choices: { final: true, but_registration: r}).first.try(:title)
      end

      but_plans.row(i).concat(row)
    end

    helper_shifts = book.create_worksheet
    helper_shifts.name = 'Helferschichten'
    header = %w(ID Name)
    Timeslot.helper_shift.order({start: :asc, end: :asc}).each do |ts|
      header << "#{I18n.l(ts.start.to_date, format: :weekday)} #{I18n.l(ts.start, format: :short_time)} #{ts.description}"
    end
    helper_shifts.row(0).default_format = bold
    helper_shifts.row(0).concat header

    ButRegistration.payed.each.with_index(1) do |r, i|
      row = [r.id, r.name]
      Timeslot.helper_shift.order({start: :asc, end: :asc}).each do |ts|
        row << r.helper_shift_timeslots.exists?(ts)
      end

      helper_shifts.row(i).concat(row)
    end

    book.write excelfile
    send_data excelfile.string, filename: "BUT-Liste Stand #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}.xls", type: 'application/vnd.ms-excel'
  end
end
