# -*- coding: utf-8 -*-
require 'spec_helper'

describe Accomodation do
  describe '#all' do
    it 'gets all accomodations' do
      expect(Accomodation.all).to eq [
        Accomodation::Dorm,
        Accomodation::DoubleRoom,
        Accomodation::SingleRoom,
        Accomodation::NoRoom
      ]
    end
  end

  context 'a subclass of base' do
    before do
      class TestAccomodation < Accomodation::Base; end
    end

    describe '#label' do
      it 'builds the label from the class name' do
        expect(TestAccomodation.label).to eq 'test_accomodation'
      end
    end

    describe '#price' do
      it 'looks up the price in the settings' do
        Settings.prices.rooms['TestAccomodation'] = 42.42
        expect(TestAccomodation.price).to eq 42.42
      end
    end

    describe '#rooms_left' do
      it 'looks up the rooms left from the settings substracted by the booked rooms' do
        Settings.room_allocations['TestAccomodation'] = 100
        expect(TestAccomodation.rooms_left).to eq 100
      end

      it 'handles infinite rooms left' do
        Settings.room_allocations['TestAccomodation'] = '∞'
        expect(TestAccomodation.rooms_left).to eq '∞'
      end
    end
  end
end
