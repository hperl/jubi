# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name_de: 'Chicago' }, { name_de: 'Copenhagen' }])
#   Mayor.create(name_de: 'Emanuel', city: cities.first)
#

# init kernteam
[
  "alex.senger@yfu-deutschland.de",
  "cg@culture-options.de",
  "gerrit.ruedebusch@yfu-deutschland.de",
  "henning.perl@yfu-deutschland.de",
  "marlena.schultz-brunn@yfu.de",
  "monika.kessler@yfu-deutschland.de",
  "nick.modersitzki@yfu-deutschland.de",
  "simon.born@yfu.de",
  "simone.stepp@yfu.de",
  "stefan.timmermann@yfu-deutschland.de",
  "yannic.schelletter@yfu-deutschland.de"
 ].each do |email|
   if User.find_by_email(email).nil?
    u = User.new(email: email, password: 'OaksIctocTrunjest', intranet_user: true, kernteam: true)
    u.skip_confirmation!
    u.save
   end
 end

## init timetable
Timeslot.destroy_all

# Donnerstag
Timeslot.create(name_de:  'Anreise', name_en: 'Arrival',
                kind:  :other,
                start: DateTime.parse('2017-06-15 15:00 +0200'),
                end:   DateTime.parse('2017-06-15 18:00 +0200'))
Timeslot.create(name_de:  'Abendessen', name_en: 'Dinner',
                kind:  'meal',
                start: DateTime.parse('2017-06-15 18:00 +0200'),
                end:   DateTime.parse('2017-06-15 20:00 +0200'))
Timeslot.create(name_de:  'Begrüßungsplenum', name_en: 'Welcome Plenary',
                kind:  :plenum,
                start: DateTime.parse('2017-06-15 21:00 +0200'),
                end:   DateTime.parse('2017-06-15 22:00 +0200'))

# Freitag
Timeslot.create(name_de:  'Frühstück', name_en: 'Breakfast',
                kind:  :meal,
                start: DateTime.parse('2017-06-16  7:30 +0200'),
                end:   DateTime.parse('2017-06-16  9:00 +0200'))
Timeslot.create(name_de:  'Workshops', name_en: 'Workshops',
                kind:  :workshop,
                start: DateTime.parse('2017-06-16  9:30 +0200'),
                end:   DateTime.parse('2017-06-16 12:00 +0200'))
Timeslot.create(name_de:  'Mittagessen', name_en: 'Lunch',
                kind:  :meal,
                start: DateTime.parse('2017-06-16 12:00 +0200'),
                end:   DateTime.parse('2017-06-16 14:00 +0200'))
Timeslot.create(name_de:  'Workshops', name_en: 'Workshops',
                kind:  :workshop,
                start: DateTime.parse('2017-06-16 14:00 +0200'),
                end:   DateTime.parse('2017-06-16 18:00 +0200'))
Timeslot.create(name_de:  'Abendessen', name_en: 'Dinner',
                kind:  :meal,
                start: DateTime.parse('2017-06-16 18:00 +0200'),
                end:   DateTime.parse('2017-06-16 20:00 +0200'))
Timeslot.create(name_de:  'After-Workshops', name_en: 'After-Workshops',
                kind:  :workshop,
                start: DateTime.parse('2017-06-16 20:00 +0200'),
                end:   DateTime.parse('2017-06-16 23:00 +0200'))

# Samstag
Timeslot.create(name_de:  'Frühstück', name_en: 'Breakfast',
                kind:  :meal,
                start: DateTime.parse('2017-06-17  7:30 +0200'),
                end:   DateTime.parse('2017-06-17  9:00 +0200'))
Timeslot.create(name_de:  'Workshops', name_en: 'Workshops',
                kind:  :workshop,
                start: DateTime.parse('2017-06-17 09:30 +0200'),
                end:   DateTime.parse('2017-06-17 12:00 +0200'))
Timeslot.create(name_de:  'Mittagessen', name_en: 'Lunch',
                kind:  :meal,
                start: DateTime.parse('2017-06-17 12:00 +0200'),
                end:   DateTime.parse('2017-06-17 14:00 +0200'))
Timeslot.create(name_de:  'Festakt', name_en: 'Anniversary Reception',
                kind:  :social,
                start: DateTime.parse('2017-06-17 14:00 +0200'),
                end:   DateTime.parse('2017-06-17 17:00 +0200'))
Timeslot.create(name_de:  'Abendessen (individuell)', name_en: 'Dinner (on your own)',
                kind:  'meal',
                start: DateTime.parse('2017-06-17 18:00 +0200'),
                end:   DateTime.parse('2017-06-17 20:00 +0200'))
Timeslot.create(name_de:  'Party', name_en: 'Anniversary Party',
                kind:  :social,
                start: DateTime.parse('2017-06-17 21:00 +0200'),
                end:   DateTime.parse('2017-06-17 23:59 +0200'))

# Sonntag
Timeslot.create(name_de:  'Frühstück', name_en: 'Breakfast',
                kind:  :meal,
                start: DateTime.parse('2017-06-18  7:30 +0200'),
                end:   DateTime.parse('2017-06-18  9:30 +0200'))
Timeslot.create(name_de:  'Abschiedsplenum', name_en: 'Farewell Plenary',
                kind:  :plenum,
                start: DateTime.parse('2017-06-18 11:00 +0200'),
                end:   DateTime.parse('2017-06-18 12:00 +0200'))
Timeslot.create(name_de:  'Lunchpakete', name_en: 'Lunch bags',
                kind:  :meal,
                start: DateTime.parse('2017-06-18 12:00 +0200'),
                end:   DateTime.parse('2017-06-18 14:00 +0200'))
Timeslot.create(name_de:  'Abreise', name_en: 'Departure',
                kind:  :other,
                start: DateTime.parse('2017-06-18 12:00 +0200'),
                end:   DateTime.parse('2017-06-18 14:00 +0200'))

# Helferschichten

#Timeslot.helper_shift.destroy_all

#Timeslot.create(name_de:  'Check-In',
                #kind:  :helper_shift,
                #description: %Q{
#Hier hilfst Du uns dabei, den Anreisenden einen möglichst reibungslosen Ablauf beim Einchecken zu ermöglichen.
                #}.strip,
                #max_tn: 2,
                #start: DateTime.parse('2017-06-14 14:00 +0200'),
                #end:   DateTime.parse('2017-06-14 16:00 +0200'))

#Timeslot.create(name_de:  'Check-In',
                #kind:  :helper_shift,
                #description: %Q{
#Hier hilfst Du uns dabei, den Anreisenden einen möglichst reibungslosen Ablauf beim Einchecken zu ermöglichen.
                #}.strip,
                #max_tn: 3,
                #start: DateTime.parse('2017-06-14 16:00 +0200'),
                #end:   DateTime.parse('2017-06-14 18:00 +0200'))

#Timeslot.create(name_de:  'Abbau Check-In',
                #kind:  :helper_shift,
                #description: %Q{
#Hier hilfst Du uns dabei, den Anreisenden einen möglichst reibungslosen Ablauf beim Einchecken zu ermöglichen.
                #}.strip,
                #max_tn: 2,
                #start: DateTime.parse('2017-06-14 18:00 +0200'),
                #end:   DateTime.parse('2017-06-14 18:30 +0200'))

## Lagerfeuer
#Timeslot.create(name_de:  'Lagerfeuer',
                #kind:  :helper_shift,
                #description: %Q{
#Hilf uns und sorg‘ dafür, dass das Feuer immer schön weiterbrennt.
                #}.strip,
                #max_tn: 4,
                #start: DateTime.parse('2017-06-14 21:00 +0200'),
                #end:   DateTime.parse('2017-06-15 00:00 +0200'))


## Kioskschichten
#kioskdesc = 'Hilf‘ uns bei einer Schicht im Kiosk und mach‘ die Anderen mit Kaffee und Schoki glücklich.'
#[#['2017-06-14 12:00 +0200', '2017-06-14 14:00 +0200'],
 #['2017-06-14 14:00 +0200', '2017-06-14 16:00 +0200'],
 #['2017-06-14 16:00 +0200', '2017-06-14 18:00 +0200'],
 #['2017-06-14 18:00 +0200', '2017-06-14 20:30 +0200'],
 #['2017-06-14 21:00 +0200', '2017-06-14 23:00 +0200'],
 #['2017-06-14 23:00 +0200', '2017-06-15 01:00 +0200'],

 #['2017-06-15 13:00 +0200', '2017-06-15 14:00 +0200'],
 #['2017-06-15 18:30 +0200', '2017-06-15 19:30 +0200'],
 #['2017-06-15 23:00 +0200', '2017-06-16 01:00 +0200'],

 #['2017-06-16 13:00 +0200', '2017-06-16 14:00 +0200'],
 #['2017-06-16 16:00 +0200', '2017-06-16 18:00 +0200'],
 #['2017-06-16 18:00 +0200', '2017-06-16 20:00 +0200']
 #].each do |(start, _end)|
  #Timeslot.create(name_de:  'Kiosk',
                  #kind:  :helper_shift,
                  #description: kioskdesc,
                  #max_tn: 2,
                  #start: DateTime.parse(start),
                  #end:   DateTime.parse(_end))
#end
#Timeslot.create(name_de:  'Kiosk',
                #kind:  :helper_shift,
                #description: kioskdesc,
                #max_tn: 3,
                #start: DateTime.parse('2017-06-17 09:00 +0200'),
                #end:   DateTime.parse('2017-06-17 11:00 +0200'))
## Kioskschichten während der Workshops
#Workshop.helper_shift.destroy_all
#Timeslot.workshop.each do |ts|
  #ts.workshops << Workshop.create(
    #helper_shift: true,
    #description: kioskdesc,
    #title: 'Helferschicht Kiosk (während der Workshops)'
  #)
#end

## Grillen
#Timeslot.create(name_de:  'Grillen',
                #kind:  :helper_shift,
                #description: "Hilf uns und sorg‘ dafür, dass das Grillgut unter die Leute kommt! Du selbst kommst dabei auch nicht zu kurz und grillst natürlich mit!",
                #max_tn: 6,
                #start: DateTime.parse('2017-06-16 17:30 +0200'),
                #end:   DateTime.parse('2017-06-16 19:30 +0200'))

## Sportturnier
#Timeslot.where(name_de: 'Sporttunier').destroy_all
#Timeslot.where(name_de: 'Sportturnier').destroy_all
#Workshop.where(title: 'Teilnahme Sportturnier (Volleyball) als Spieler').destroy_all
#Workshop.where(title: 'Teilnahme Sportturnier (Volleyball) als Schiri').destroy_all
#Workshop.where(title: 'Teilnahme Sportturnier (Volleyball) als Fan').destroy_all

#sportturnier = Timeslot.create(name_de:  'Sportturnier',
                #kind:  :tournament,
                #description: 'Am Samstag Nachmittag findet als große gemeinsame Aktivität ein Sportturnier statt. Du kannst entweder als Spieler, als Schiri oder als Fan mitmachen oder helfen.',
                #start: DateTime.parse('2017-06-16 16:00 +0200'),
                #end:   DateTime.parse('2017-06-16 17:30 +0200'))
#sportturnier.workshops << Workshop.create!(
  #helper_shift: true,
  #description: 'Damit das Sportturnier ein voller Erfolg wird, brauchen wir noch ein paar Helfer für’s Drumherum.',
  #title: 'Helferschicht während des Sportturniers',
  #max_tn: 4
#)
#sportturnier.workshops << Workshop.create!(
  #title: 'Teilnahme Sportturnier (Volleyball) als Spieler',
  #description: 'Tob dich aus und trete mit deiner Mannschaft gegen andere an.',
  #timeframe: '90',
  #visible: true
#)
#sportturnier.workshops << Workshop.create!(
  #title: 'Teilnahme Sportturnier (Volleyball) als Schiri',
  #description: 'Kläre Regelfragen während des Spiels.',
  #timeframe: '90',
  #visible: true
#)
#sportturnier.workshops << Workshop.create!(
  #title: 'Teilnahme Sportturnier (Volleyball) als Fan',
  #description: 'Feuer deine Lieblingsmannschaft an.',
  #timeframe: '90',
  #visible: true
#)

## Partyschichten
#Timeslot.create(name_de:  'Aufbau Party',
                #kind:  :helper_shift,
                #description: "Hilf' mit bei den Partyvorbereitungen und sorg' mit uns dafür, dass später alle super feiern können!",
                #max_tn: 3,
                #start: DateTime.parse('2017-06-16 19:30 +0200'),
                #end:   DateTime.parse('2017-06-16 21:00 +0200'))
#[['2017-06-16 20:45 +0200', '2017-06-16 22:15 +0200'],
 #['2017-06-16 22:00 +0200', '2017-06-16 23:30 +0200'],
 #['2017-06-16 23:15 +0200', '2017-06-17 00:45 +0200'],
 #['2017-06-17 00:30 +0200', '2017-06-17 02:00 +0200'],
 #['2017-06-17 01:45 +0200', '2017-06-17 03:15 +0200'],
 #['2017-06-17 03:00 +0200', '2017-06-17 04:30 +0200']].each do |(start, _end)|
  #Timeslot.create(name_de:  'Party',
                  #kind:  :helper_shift,
                  #description: 'Hilf‘ bei der Party und sorg‘ an der Theke dafür, dass jeder versorgt wird!',
                  #max_tn: 2,
                  #start: DateTime.parse(start),
                  #end:   DateTime.parse(_end))
#end

## Freestylerschichten
#[['2017-06-14 08:00 +0200', '2017-06-14 22:00 +0200'],
 #['2017-06-15 08:00 +0200', '2017-06-15 22:00 +0200'],
 #['2017-06-16 08:00 +0200', '2017-06-16 22:00 +0200'],
 #['2017-06-17 08:00 +0200', '2017-06-17 22:00 +0200']].each do |(start, _end)|
   #Timeslot.create(name_de: 'Freestyler',
                   #kind: :helper_shift,
                   #description: "Meld' dich heute als Freestyler, sodass wir, wenn gerade mal spontan Hilfe benötigt wird, auf dich zurückgreifen können. Keine Sorge, Workshops kannst du trotzdem wählen, darauf nehmen wir Rücksicht!",
                   #start: DateTime.parse(start),
                   #end:   DateTime.parse(_end))
#end

## Abbau
#abbau_desc = 'Nach einem tollen BUT brauchen wir Eure Hilfe, um am Sonntag gemeinsam möglichst schnell klar Schiff zu machen. Je mehr wir hier sind, desto weniger Arbeit ist es für jeden Einzelnen und desto schneller sind wir fertig!'
#Timeslot.create(name_de:  'Abbau Party und Lounge',
                #kind:  :helper_shift,
                #description: abbau_desc,
                #max_tn: 10,
                #start: DateTime.parse('2017-06-17 09:30 +0200'),
                #end:   DateTime.parse('2017-06-17 11:00 +0200'))
#Timeslot.create(name_de:  'Abbau Gelände',
                #kind:  :helper_shift,
                #description: abbau_desc,
                #max_tn: 10,
                #start: DateTime.parse('2017-06-17 09:30 +0200'),
                #end:   DateTime.parse('2017-06-17 11:00 +0200'))
#Timeslot.create(name_de:  'Abbau Gelände',
                #kind:  :helper_shift,
                #description: abbau_desc,
                #max_tn: 5,
                #start: DateTime.parse('2017-06-17 13:30 +0200'),
                #end:   DateTime.parse('2017-06-17 15:00 +0200'))
