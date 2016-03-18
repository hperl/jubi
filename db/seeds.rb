# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

# init kernteam
[
  "henning.perl@yfu-deutschland.de",
  "cg@culture-options.de",
  "schultz-brunn@yfu.de",
  "simon.born@yfu.de",
  "stepp@yfu.de",
  "nick.modersitzki@yfu-deutschland.de",
  "yannic.schelletter@yfu-deutschland.de",
  "veer@yfu.de",
  "stefan.timmermann@yfu-deutschland.de",
  "alexander.senger@yfu-deutschland.de",
].each do |email|
   if User.find_by_email(email).nil?
    u = User.new(email: email, password: 'OaksIctocTrunjest', intranet_user: true, kernteam: true)
    u.skip_confirmation!
    u.save
   end
 end

## init timetable
#Timeslot.destroy_all

## Donnerstag
#Timeslot.create(name:  'Check-In',
                #kind:  :helper_shift,
                #start: DateTime.parse('2015-05-14 15:30 +0200'),
                #end:   DateTime.parse('2015-05-14 17:30 +0200'))
#Timeslot.create(name:  'Lagerfeuer',
                #kind:  :helper_shift,
                #start: DateTime.parse('2015-05-14 20:00 +0200'),
                #end:   DateTime.parse('2015-05-14 23:00 +0200'))
#Timeslot.create(name:  'Anreise',
                #kind:  :other,
                #start: DateTime.parse('2015-05-14 15:30 +0200'),
                #end:   DateTime.parse('2015-05-14 17:30 +0200'))
#Timeslot.create(name:  'Abendessen',
                #kind:  'meal',
                #start: DateTime.parse('2015-05-14 17:30 +0200'),
                #end:   DateTime.parse('2015-05-14 19:30 +0200'))
#Timeslot.create(name:  'Begrüßungsplenum',
                #kind:  :plenum,
                #start: DateTime.parse('2015-05-14 20:30 +0200'),
                #end:   DateTime.parse('2015-05-14 21:00 +0200'))

## Freitag
#Timeslot.create(name:  'Frühstück',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-15  7:30 +0200'),
                #end:   DateTime.parse('2015-05-15  9:00 +0200'))
#Timeslot.create(name:  'Workshops',
                #kind:  :workshop,
                #start: DateTime.parse('2015-05-15  9:30 +0200'),
                #end:   DateTime.parse('2015-05-15 12:00 +0200'))
#Timeslot.create(name:  'Mittagessen',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-15 12:00 +0200'),
                #end:   DateTime.parse('2015-05-15 13:30 +0200'))
#Timeslot.create(name:  'Workshops',
                #kind:  :workshop,
                #start: DateTime.parse('2015-05-15 14:00 +0200'),
                #end:   DateTime.parse('2015-05-15 16:30 +0200'))
#Timeslot.create(name:  'Vorbereitung LG-Challenge',
                #kind:  :social,
                #start: DateTime.parse('2015-05-15 16:30 +0200'),
                #end:   DateTime.parse('2015-05-15 17:30 +0200'))
#Timeslot.create(name:  'Abendessen',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-15 17:30 +0200'),
                #end:   DateTime.parse('2015-05-15 19:30 +0200'))
#Timeslot.create(name:  'Startschuss LG-Challenge',
                #kind:  :plenum,
                #start: DateTime.parse('2015-05-15 19:30 +0200'),
                #end:   DateTime.parse('2015-05-15 20:00 +0200'))
#Timeslot.create(name:  'LG-Challenge',
                #kind:  :social,
                #start: DateTime.parse('2015-05-15 20:00 +0200'),
                #end:   DateTime.parse('2015-05-15 23:00 +0200'))
#Timeslot.create(name:  'Raumcheck nach LG-Challenge',
                #kind:  :helper_shift,
                #start: DateTime.parse('2015-05-15 23:00 +0200'),
                #end:   DateTime.parse('2015-05-15 23:59 +0200'))

## Samstag
#Timeslot.create(name:  'Frühstück',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-16  7:30 +0200'),
                #end:   DateTime.parse('2015-05-16  9:00 +0200'))
#Timeslot.create(name:  'Workshops',
                #kind:  :workshop,
                #start: DateTime.parse('2015-05-16 09:30 +0200'),
                #end:   DateTime.parse('2015-05-16 11:30 +0200'))
#Timeslot.create(name:  'Siegerehrung LG-Challenge',
                #kind:  :plenum,
                #start: DateTime.parse('2015-05-16 11:30 +0200'),
                #end:   DateTime.parse('2015-05-16 12:00 +0200'))
#Timeslot.create(name:  'Mittagessen',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-16 12:00 +0200'),
                #end:   DateTime.parse('2015-05-16 13:30 +0200'))
#Timeslot.create(name:  'Workshops',
                #kind:  :workshop,
                #start: DateTime.parse('2015-05-16 14:00 +0200'),
                #end:   DateTime.parse('2015-05-16 16:00 +0200'))
##Timeslot.create(name:  'Workshops',
                ##kind:  :workshop,
                ##start: DateTime.parse('2015-05-16 16:00 +0200'),
                ##end:   DateTime.parse('2015-05-16 17:30 +0200'))
#Timeslot.create(name:  'Sporttunier',
                #kind:  :social,
                #start: DateTime.parse('2015-05-16 16:00 +0200'),
                #end:   DateTime.parse('2015-05-16 17:30 +0200'))
#Timeslot.create(name:  'Grillen',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-16 17:30 +0200'),
                #end:   DateTime.parse('2015-05-16 19:30 +0200'))
#Timeslot.create(name:  'Party',
                #kind:  :social,
                #start: DateTime.parse('2015-05-16 21:00 +0200'),
                #end:   DateTime.parse('2015-05-16 23:59 +0200'))

## Sonntag
#Timeslot.create(name:  'Frühstück',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-17  7:30 +0200'),
                #end:   DateTime.parse('2015-05-17  9:30 +0200'))
#Timeslot.create(name:  'Workshops',
                #kind:  :workshop,
                #start: DateTime.parse('2015-05-17  9:30 +0200'),
                #end:   DateTime.parse('2015-05-17 11:00 +0200'))
#Timeslot.create(name:  'Abschiedsplenum',
                #kind:  :plenum,
                #start: DateTime.parse('2015-05-17 11:00 +0200'),
                #end:   DateTime.parse('2015-05-17 12:00 +0200'))
#Timeslot.create(name:  'Mittagessen',
                #kind:  :meal,
                #start: DateTime.parse('2015-05-17 12:00 +0200'),
                #end:   DateTime.parse('2015-05-17 13:30 +0200'))
#Timeslot.create(name:  'Abreise',
                #kind:  :other,
                #start: DateTime.parse('2015-05-17 13:30 +0200'),
                #end:   DateTime.parse('2015-05-17 15:30 +0200'))

# Helferschichten

#Timeslot.helper_shift.destroy_all

#Timeslot.create(name:  'Check-In',
                #kind:  :helper_shift,
                #description: %Q{
#Hier hilfst Du uns dabei, den Anreisenden einen möglichst reibungslosen Ablauf beim Einchecken zu ermöglichen.
                #}.strip,
                #max_tn: 2,
                #start: DateTime.parse('2015-05-14 14:00 +0200'),
                #end:   DateTime.parse('2015-05-14 16:00 +0200'))

#Timeslot.create(name:  'Check-In',
                #kind:  :helper_shift,
                #description: %Q{
#Hier hilfst Du uns dabei, den Anreisenden einen möglichst reibungslosen Ablauf beim Einchecken zu ermöglichen.
                #}.strip,
                #max_tn: 3,
                #start: DateTime.parse('2015-05-14 16:00 +0200'),
                #end:   DateTime.parse('2015-05-14 18:00 +0200'))

#Timeslot.create(name:  'Abbau Check-In',
                #kind:  :helper_shift,
                #description: %Q{
#Hier hilfst Du uns dabei, den Anreisenden einen möglichst reibungslosen Ablauf beim Einchecken zu ermöglichen.
                #}.strip,
                #max_tn: 2,
                #start: DateTime.parse('2015-05-14 18:00 +0200'),
                #end:   DateTime.parse('2015-05-14 18:30 +0200'))

## Lagerfeuer
#Timeslot.create(name:  'Lagerfeuer',
                #kind:  :helper_shift,
                #description: %Q{
#Hilf uns und sorg‘ dafür, dass das Feuer immer schön weiterbrennt.
                #}.strip,
                #max_tn: 4,
                #start: DateTime.parse('2015-05-14 21:00 +0200'),
                #end:   DateTime.parse('2015-05-15 00:00 +0200'))


## Kioskschichten
#kioskdesc = 'Hilf‘ uns bei einer Schicht im Kiosk und mach‘ die Anderen mit Kaffee und Schoki glücklich.'
#[#['2015-05-14 12:00 +0200', '2015-05-14 14:00 +0200'],
 #['2015-05-14 14:00 +0200', '2015-05-14 16:00 +0200'],
 #['2015-05-14 16:00 +0200', '2015-05-14 18:00 +0200'],
 #['2015-05-14 18:00 +0200', '2015-05-14 20:30 +0200'],
 #['2015-05-14 21:00 +0200', '2015-05-14 23:00 +0200'],
 #['2015-05-14 23:00 +0200', '2015-05-15 01:00 +0200'],

 #['2015-05-15 13:00 +0200', '2015-05-15 14:00 +0200'],
 #['2015-05-15 18:30 +0200', '2015-05-15 19:30 +0200'],
 #['2015-05-15 23:00 +0200', '2015-05-16 01:00 +0200'],

 #['2015-05-16 13:00 +0200', '2015-05-16 14:00 +0200'],
 #['2015-05-16 16:00 +0200', '2015-05-16 18:00 +0200'],
 #['2015-05-16 18:00 +0200', '2015-05-16 20:00 +0200']
 #].each do |(start, _end)|
  #Timeslot.create(name:  'Kiosk',
                  #kind:  :helper_shift,
                  #description: kioskdesc,
                  #max_tn: 2,
                  #start: DateTime.parse(start),
                  #end:   DateTime.parse(_end))
#end
#Timeslot.create(name:  'Kiosk',
                #kind:  :helper_shift,
                #description: kioskdesc,
                #max_tn: 3,
                #start: DateTime.parse('2015-05-17 09:00 +0200'),
                #end:   DateTime.parse('2015-05-17 11:00 +0200'))
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
#Timeslot.create(name:  'Grillen',
                #kind:  :helper_shift,
                #description: "Hilf uns und sorg‘ dafür, dass das Grillgut unter die Leute kommt! Du selbst kommst dabei auch nicht zu kurz und grillst natürlich mit!",
                #max_tn: 6,
                #start: DateTime.parse('2015-05-16 17:30 +0200'),
                #end:   DateTime.parse('2015-05-16 19:30 +0200'))

## Sportturnier
#Timeslot.where(name: 'Sporttunier').destroy_all
#Timeslot.where(name: 'Sportturnier').destroy_all
#Workshop.where(title: 'Teilnahme Sportturnier (Volleyball) als Spieler').destroy_all
#Workshop.where(title: 'Teilnahme Sportturnier (Volleyball) als Schiri').destroy_all
#Workshop.where(title: 'Teilnahme Sportturnier (Volleyball) als Fan').destroy_all

#sportturnier = Timeslot.create(name:  'Sportturnier',
                #kind:  :tournament,
                #description: 'Am Samstag Nachmittag findet als große gemeinsame Aktivität ein Sportturnier statt. Du kannst entweder als Spieler, als Schiri oder als Fan mitmachen oder helfen.',
                #start: DateTime.parse('2015-05-16 16:00 +0200'),
                #end:   DateTime.parse('2015-05-16 17:30 +0200'))
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
#Timeslot.create(name:  'Aufbau Party',
                #kind:  :helper_shift,
                #description: "Hilf' mit bei den Partyvorbereitungen und sorg' mit uns dafür, dass später alle super feiern können!",
                #max_tn: 3,
                #start: DateTime.parse('2015-05-16 19:30 +0200'),
                #end:   DateTime.parse('2015-05-16 21:00 +0200'))
#[['2015-05-16 20:45 +0200', '2015-05-16 22:15 +0200'],
 #['2015-05-16 22:00 +0200', '2015-05-16 23:30 +0200'],
 #['2015-05-16 23:15 +0200', '2015-05-17 00:45 +0200'],
 #['2015-05-17 00:30 +0200', '2015-05-17 02:00 +0200'],
 #['2015-05-17 01:45 +0200', '2015-05-17 03:15 +0200'],
 #['2015-05-17 03:00 +0200', '2015-05-17 04:30 +0200']].each do |(start, _end)|
  #Timeslot.create(name:  'Party',
                  #kind:  :helper_shift,
                  #description: 'Hilf‘ bei der Party und sorg‘ an der Theke dafür, dass jeder versorgt wird!',
                  #max_tn: 2,
                  #start: DateTime.parse(start),
                  #end:   DateTime.parse(_end))
#end

## Freestylerschichten
#[['2015-05-14 08:00 +0200', '2015-05-14 22:00 +0200'],
 #['2015-05-15 08:00 +0200', '2015-05-15 22:00 +0200'],
 #['2015-05-16 08:00 +0200', '2015-05-16 22:00 +0200'],
 #['2015-05-17 08:00 +0200', '2015-05-17 22:00 +0200']].each do |(start, _end)|
   #Timeslot.create(name: 'Freestyler',
                   #kind: :helper_shift,
                   #description: "Meld' dich heute als Freestyler, sodass wir, wenn gerade mal spontan Hilfe benötigt wird, auf dich zurückgreifen können. Keine Sorge, Workshops kannst du trotzdem wählen, darauf nehmen wir Rücksicht!",
                   #start: DateTime.parse(start),
                   #end:   DateTime.parse(_end))
#end

## Abbau
#abbau_desc = 'Nach einem tollen BUT brauchen wir Eure Hilfe, um am Sonntag gemeinsam möglichst schnell klar Schiff zu machen. Je mehr wir hier sind, desto weniger Arbeit ist es für jeden Einzelnen und desto schneller sind wir fertig!'
#Timeslot.create(name:  'Abbau Party und Lounge',
                #kind:  :helper_shift,
                #description: abbau_desc,
                #max_tn: 10,
                #start: DateTime.parse('2015-05-17 09:30 +0200'),
                #end:   DateTime.parse('2015-05-17 11:00 +0200'))
#Timeslot.create(name:  'Abbau Gelände',
                #kind:  :helper_shift,
                #description: abbau_desc,
                #max_tn: 10,
                #start: DateTime.parse('2015-05-17 09:30 +0200'),
                #end:   DateTime.parse('2015-05-17 11:00 +0200'))
#Timeslot.create(name:  'Abbau Gelände',
                #kind:  :helper_shift,
                #description: abbau_desc,
                #max_tn: 5,
                #start: DateTime.parse('2015-05-17 13:30 +0200'),
                #end:   DateTime.parse('2015-05-17 15:00 +0200'))
