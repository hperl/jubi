#encoding: utf-8

class InvitationMailer < ActionMailer::Base
  default from: "nicht-antworten@but.yfu.de"

  def invite(invitation)
    headers "Auto-Submitted" => "auto-generated",
            "Precedence"     => "bulk"
    @invitation = invitation
    mail(to: @invitation.email, subject: "[BUT] Du wurdest zur Gruppe »#{@invitation.group.name}« eingeladen")
  end
end
