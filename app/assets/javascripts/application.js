// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require vendor/modernizr
//= require_tree .

$(function(){
  // foundation
  $(document).foundation();

  // zeitplan
  var totalHeight = 0
  $.each($('.timeslot'), function() {
    var factor = 1.6
      , $el = $(this)
      , top = ($el.data('start') - 7) * factor
      , height = ($el.data('end') - $el.data('start')) * factor - 0.1
    $el
      .css('top', top + 'cm')
      .css('height', height + 'cm')
    totalHeight = Math.max(totalHeight, top + height)
  })
  $('.timeslots').css('height', totalHeight + 'cm')

  // ckeditor
  if ($('textarea').length > 0) {
    var el = $('textarea.ckeditor');
    $.each(el, function(i) {
      CKEDITOR.replace(el[i].id);
    });
  }

  // loading state
  $('body').on('ajax:send', function(xhr) { $(xhr.target).addClass('loading') });

  // Plan dein BUT Filter
  $('#filterAllVisible').on('click', function(ev) {
    $('.workshop, .helper-shift').show()
    $('.filter dd').removeClass('active')
    $('#filterAllVisible').parent('dd').addClass('active')
    $(ev.target).parent('dd').addClass('active')
    $(document).foundation('magellan', 'reflow')
    return false
  })
  $('#filterWorkshopsVisible').on('click', function(ev) {
    $('.workshop').show()
    $('.helper-shift').hide()
    $('.filter dd').removeClass('active')
    $('#filterWorkshopsVisible').parent('dd').addClass('active')
    $(ev.target).parent('dd').addClass('active')
    $(document).foundation('magellan', 'reflow')
    return false
  })
  $('#filterHelperShiftsVisible').on('click', function(ev) {
    $('.workshop').hide()
    $('.helper-shift').show()
    $('.filter dd').removeClass('active')
    $('#filterHelperShiftsVisible').parent('dd').addClass('active')
    $(ev.target).parent('dd').addClass('active')
    $(document).foundation('magellan', 'reflow')
    return false
  })
});
