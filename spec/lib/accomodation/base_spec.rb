# -*- coding: utf-8 -*-
require 'spec_helper'

describe Accomodation::Base do
  describe '#all' do
    it 'gets all accomodations' do
      expect(Accomodation.all).to eq [
        Accomodation::Dorm,
        Accomodation::DoubleRoom,
        Accomodation::SingleRoom
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
        Settings.prices.rooms.test_accomodation = 42.42
        expect(TestAccomodation.price).to eq 42.42
      end
    end
  end
end
