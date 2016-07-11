hideOrSlide = function(animate, el) {
    if (animate) {
        el.slideUp();
    } else {
        el.hide();
    }
};

toggleTogetherWith = function(animate) {
    var hide = $('#but_registration_accomodation_acc_single')[0].checked || $('#but_registration_accomodation_acc_none')[0].checked;
    var el = $('#together-with');
    if (hide) {
        hideOrSlide(animate, el);
    } else {
        el.slideDown();
    }
};

toggleDietOther = function(animate) {
    var show = $('#but_registration_diet_other_diet')[0].checked;
    var el = $('#but_registration_diet_other');
    if (!show) {
        hideOrSlide(animate, el);
    } else {
        el.slideDown();
        el.focus();
    }
};
