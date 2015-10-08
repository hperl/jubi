class Algorithm

  def run
    WorkshopChoice.transaction do
      # clear out previous run
      WorkshopChoice.delete_all(final: true)

      # before participants, handle trainers
      Workshop.where('user_id is not null').each do |workshop|
        workshop.training_registrations.each do |registration|
          WorkshopChoice.create(
            but_registration: registration,
            workshop: workshop,
            choice_type: WorkshopChoice.choice_types['first_choice'],
            final: true,
            trainer: true
          )
        end
      end

      Timeslot.workshop.order('start').each do |workshop_slot|
        # first handle first choice, then second choice etc.
        for choice_type in %w(first_choice second_choice third_choice) do
          # workshops ordered by max_tn so that we give away small workshops first
          workshop_slot.workshops.order('max_tn').each do |workshop|
            spaces_left = workshop.spaces_left
            choices = workshop.workshop_choices.send(choice_type).where(final: false).joins(:but_registration).to_a
            # reverse sorted by karma:
            choices.sort! { |a, b| b.but_registration.karma <=> a.but_registration.karma }
            choices.each do |choice|
              # abort if no spaces left
              if spaces_left <= 0
                break
              end

              # skip if registration already chose a workshop in that slot
              final_timeslots = Timeslot
              .joins(workshops: :workshop_choices)
              .where(workshop_choices: {but_registration_id: choice.but_registration_id, final: true})


              if choice.workshop.timeslots.any? { |ts| ts.in? final_timeslots }
                next
              end

              # you get the spot!
              spaces_left -= 1
              c = choice.dup
              c.final = true
              c.save!
            end
          end
        end
      end
    end
  end
end
