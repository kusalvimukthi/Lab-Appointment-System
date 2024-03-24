
$.fn.reset = function() {
    $(this).find('.is-invalid').removeClass('is-invalid');
    $(this).find('.form-control').val('');
    $(this).find('[type="checkbox"]').prop( "checked", false );
    $(this).validate().resetForm();
};

var please_wait = "please wait";

var submitText = '';

(function($) {
    $.fn.load = function() {
        submitText = jQuery(this).find('[type="submit"]').text();
        jQuery(this).find('[type="submit"]').attr('disabled', 'true').html('<div class="fa fa-spinner rotate-refresh"><div class="ldio-9po26bv9odj"><div></div></div></div>'+please_wait);
    };

    $.fn.unload = function() {
        if (submitText) {
            jQuery(this).find('[type="submit"]').removeAttr('disabled').html(submitText);
        }
    };

    $.fn.unloadBtn = function() {
        if (submitText) {
            jQuery(this).removeAttr('disabled').html(submitText);
        }
    };

    $.fn.loadText = function() {
        submitText = jQuery(this).text();
        jQuery(this).attr('disabled', 'true').html('<div class="fa fa-spinner rotate-refresh"><div class="ldio-9po26bv9odj"><div></div></div></div> '+please_wait);
    };

    $.fn.unloadText = function() {
        if (submitText) {
            jQuery(this).removeAttr('disabled').html(submitText);
        }
    };

    $.fn.btnLoad = function() {
        submitText = jQuery(this).find('[type="submit"]').html();
        jQuery(this).find('[type="submit"]').attr('disabled', 'true').html('<div class="fa fa-spinner rotate-refresh"><div class="ldio-9po26bv9odj"><div></div></div></div>'+please_wait);
    };

    $.fn.btnUnload = function() {
        if (submitText) {
            jQuery(this).find('[type="submit"]').removeAttr('disabled').html(submitText);
        }
    };


    $.fn.reset = function() {
        $(this).find('.is-invalid').removeClass('is-invalid');
        $(this).find('.form-control').val('');
        $(this).find('[type="checkbox"]').prop( "checked", false );
        $(this).validate().resetForm();
    };

    $.fn.resetElement = function() {
        $(this).closest('.form-group').find('.is-invalid').removeClass('is-invalid');
        $(this).val('');
        $(this).validate().resetForm();
    };

    $.fn.scrollT = function() {
        $(this).scrollTop(0);
    };

})(jQuery);


jQuery("#formAuthentication").validate({

    rules: {

        "email": {
            required: !0,
            email: !0
        },
        "password": {
            required: !0,
            minlength: 8
        }

    },
    messages: {

        "email": {
            required: "Your email is required",
            email: "Please enter a valid email address",
        },
        "password": {
            required: "Your password is required",
        }
    },

    ignore: ':hidden',
    errorClass: "invalid-feedback animated fadeInUp",
    errorElement: "div",
    errorPlacement: function(e, a) {
        jQuery(a).parents(".form-group").append(e)
    },
    highlight: function(e) {
        jQuery(e).closest(".form-group").removeClass("is-invalid").addClass("is-invalid"),
            jQuery(e).closest(".form-group").find('.form-control').removeClass("is-invalid").addClass("is-invalid")
    },
    success: function(e) {
        jQuery(e).closest(".form-group").removeClass("is-invalid"), jQuery(e).closest(".form-group").find('.form-control').removeClass("is-invalid"), jQuery(e).remove()
    },
});


jQuery("#register-form").validate({

    rules: {

        "f_name": {
            required: true
        },
        "l_name": {
            required: true
        },
        "nic": {
            required: true
        },
        "telephone": {
            required: true
        },
        "dob": {
            required: true
        },
        "email": {
            required: true,
            email: true
        },
        "password": {
            required: true,
            minlength: 8
        },
        "confPassword": {
            required: true,
            equalTo: "#pass"
        },
        "agree-term": {
            required: true
        }
    },
    messages: {

        "f_name": {
            required: "Please enter your first name"
        },
        "l_name": {
            required: "Please enter your last name"
        },
        "nic": {
            required: "Please enter your NIC"
        },
        "telephone": {
            required: "Please enter your telephone number"
        },
        "dob": {
            required: "Please enter your Date of Birth"
        },
        "email": {
            required: "Please enter your email",
            email: "Please enter a valid email address"
        },
        "password": {
            required: "Please enter a password",
            minlength: "Your password must be at least 6 characters long"
        },
        "re_pass": {
            required: "Please confirm your password",
            equalTo: "Passwords do not match"
        },
        "agree-term": {
            required: "You must agree to the privacy policy and terms"
        }
    },

    ignore: ':hidden',
    errorClass: "invalid-feedback animated fadeInUp",
    errorElement: "div",
    errorPlacement: function(e, a) {
        jQuery(a).parents(".form-group").append(e)
    },
    highlight: function(e) {
        jQuery(e).closest(".form-group").removeClass("is-invalid").addClass("is-invalid"),
            jQuery(e).closest(".form-group").find('.form-control').removeClass("is-invalid").addClass("is-invalid")
    },
    success: function(e) {
        jQuery(e).closest(".form-group").removeClass("is-invalid"), jQuery(e).closest(".form-group").find('.form-control').removeClass("is-invalid"), jQuery(e).remove()
    },
});





