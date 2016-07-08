# -*- coding: utf-8 -*-
require 'rails_helper'
require 'pry'

describe User do
  describe "registrations" do
    context "with one party and one conference registration" do
      subject(:user) do
        User.new(
          conference_registrations: [ConferenceRegistration.new],
          party_registrations: [PartyRegistration.new]
        )
      end

      it "should have two registrations" do
        user.registrations.size.should eq(2)
      end
    end
  end

  context "registration is not frozen" do
    before { Settings.dates.registrations_frozen = Time.now + 1.year }

    describe "displayname" do
      let(:p_meier_1) { Person.new(name: "Heinz von Meier") }
      let(:p_meier_2) { Person.new(name: "Franz von Meier") }
      let(:p_schulze) { Person.new(name: "Mia Schulze") }

      context "New user" do
        subject(:user) { User.new(email: "bla@blub.de") }

        it {user.displayname.should eq(user.email)}
      end

      context "with one registration" do
        subject(:user) { User.new(people: [p_meier_1]) }
        it { user.displayname.should eq("Heinz von Meier") }
      end

      context "with a family" do
        subject(:user) { User.new(people: [p_meier_1, p_meier_2]) }
        it { user.displayname.should eq("Heinz und Franz von Meier") }
      end

      context "with two unrelated people" do
        subject(:user) { User.new(people: [p_meier_1, p_meier_2, p_schulze]) }
        it { user.displayname.should eq("Heinz von Meier, Franz von Meier und Mia Schulze") }
      end
    end

    describe "abilities" do
      subject(:ability) { Ability.new(user) }

      context "when is in BUT Kernteam" do
        let(:user) { User.new(kernteam: true) }

        it { should be_able_to(:manage, :but_board) }
      end

      context "normal user" do
        let(:user)               { stub_model User }
        let(:own_workshop)       { Workshop.new(owner: user) }
        let(:other_workshop)     { Workshop.new }
        let(:own_registration)   { ConferenceRegistration.new(user: user) }
        let(:other_registration) { ConferenceRegistration.new }
        let(:own_group)          { Group.new(owner: user) }
        let(:group_user_is_in)   { Group.new(users: [user]) }
        let(:other_group)        { Group.new }

        it { should_not be_able_to(:manage, :all) }

        it { should     be_able_to(:manage, user) }
        it { should_not be_able_to(:manage, User.new) }

        # allow create and manage own workshop
        it { should     be_able_to(:create, Workshop)     }
        it { should     be_able_to(:crud, own_workshop)   }
        it { should_not be_able_to(:crud, other_workshop) }

        # allow create and manage own workshop
        it { should     be_able_to(:create, ConferenceRegistration)    }
        it { should     be_able_to(:manage, own_registration)   }
        it { should_not be_able_to(:manage, other_registration) }

        # allow creation of group, read and manage own groups
        it { should     be_able_to(:create, Group)            }
        it { should     be_able_to(:manage, own_group)        }
        it { should     be_able_to(:read,   group_user_is_in) }
        it { should_not be_able_to(:manage, other_group)      }
        it { should_not be_able_to(:read,   other_group)      }
      end

      context "guest" do
        let(:user) { nil }

        it { should     be_able_to(:read, Workshop) }
        it { should_not be_able_to(:read, Group) }
        it { should_not be_able_to(:read, User) }
        it { should_not be_able_to(:read, ConferenceRegistration) }
      end
    end

    # TODO commented out for now, implement payment functionality in Registerable!
    describe "mark registrations as payed" do
      let :registrations do
        [stub_model(ConferenceRegistration), stub_model(PartyRegistration)]
      end
      let :user do
        stub_model(User, registrations: registrations) 
      end

      context "User has no money" do
        it "does not mark registrations as payed" do
          user.mark_registrations_as_payed

          registrations.each { |r| expect(r.state).to eq 'unpayed' }
        end
      end

      context "User has money for all registrations" do
        it "marks registrations as payed" do
          registrations.each do |registration|
            user.payments << Payment.new(amount_in_cents: registration.price * 100)
          end
          user.mark_registrations_as_payed

          registrations.each { |r| expect(r.state).to eq 'payed' }
        end
      end
    end


    #   context "User has money for some registrations" do
    #     it "does not mark registrations as payed" do
    #       reg1 = ButRegistration.create!({name: "bla", address: "12345", sex: 0, age: 100, t_shirt_size: "Männerschnitt S", state: 0})
    #       reg2 = ButRegistration.create!({name: "bla", address: "12345", sex: 0, age: 100, t_shirt_size: "Männerschnitt S", state: 0})
    #       user = stub_model(User, balance: -reg2.price, registrations: [reg1, reg2])
    #       user.mark_registrations_as_payed
    #       reg1.state.should_not eq('payed')
    #       reg2.state.should_not eq('payed')
    #     end
    #   end
    # end

    # TODO Find out early bird logic first!
    # context "early bird registration not passed" do
    #   before { Settings.dates.early_bird_registration_passed = Time.now + 1.year }
    #   describe "cancel registration" do
    #     it "reimburses user minus cancellation fee" do
    #       reg = ButRegistration.create!({
    #         name: "bla",
    #         address: "12345",
    #         sex: 0, age: 100,
    #         t_shirt_size: "Männerschnitt S"
    #       })
    #       reg.state = 'cancelled'
    #       reg.price.should eq(5)
    #     end
    #   end
    # end
  end
end
