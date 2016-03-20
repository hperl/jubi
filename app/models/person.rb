# -*- coding: utf-8 -*-
class Person < ActiveRecord::Base
  # The Person model stores the personal information of an attendee

  belongs_to :user

  enum lg: %w(keine Berlin Bayern Brandenburg-Mecklenburg-Vorpommern Main-Rhein-Saar Hamburg Mitteldeutschland Nord-West Niedersachsen-Hannover Rheinland Schleswig-Holstein Südwest Westfalen)

  validates :user, :name, :address, :age, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
end
