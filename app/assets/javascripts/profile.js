toggleTogetherWith = function(animate) {
    var hide = $('#but_registration_accomodation_acc_single')[0].checked || $('#but_registration_accomodation_acc_none')[0].checked;
    var el = $('#together-with');
    if (hide) {
        animate ? el.slideUp() : el.hide();
    } else {
        el.slideDown();
    }
};

toggleDietOther = function(animate) {
    var show = $('#but_registration_diet_other_diet')[0].checked;
    var el = $('#but_registration_diet_other');
    if (!show) {
        animate ? el.slideUp() : el.hide();
    } else {
        el.slideDown();
        el.focus();
    }
};
