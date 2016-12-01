jQuery(document).on('ready page:load page:restore', function() {
    var windowScrollCoordinates = 0;
    jQuery.fn.extend({
        linkWidth: function() {
            var totalContentWidth = jQuery('#chat-table').outerWidth();

            var width = jQuery(window).width() / 2 - totalContentWidth / 2;
            if (width < 30) {
                return false;
            } else {
                $(this).css({
                    'padding-right': width / 2,
                    'padding-left': width / 2
                });
                return true;
            }
        }
    });

    jQuery.fn.extend({
        updateLink: function() {
            if ($(window).scrollTop() >= 50) {
                $(this).fadeIn(300);
            } else {
                $(this).fadeOut(300);
            }
        }
    });

    jQuery(function() {
        var topLink = $('#top-link');
        var predLink = $('#pred-link');

        topLink.css({
            'padding-bottom': $(window).height()
        });
        predLink.css({
            'padding-top': $(window).height() - 35
        });
        predLink.linkWidth();
        topLink.linkWidth();

        $(window).resize(function() {
            predLink.linkWidth();
            topLink.linkWidth();
        });

        $(window).scroll(function() {
            if ($(window).scrollTop() == 0) {
                topLink.hide();
                predLink.show();
            } else if (predLink.is(':visible')) {
                predLink.hide();
            }
            topLink.updateLink();
        });

        topLink.click(function() {
            windowScrollCoordinates = $(window).scrollTop()
            $("body,html").animate({
                scrollTop: 0
            }, 500);
        });

        predLink.click(function() {
            $("body,html").animate({
                scrollTop: windowScrollCoordinates
            }, 500);
            predLink.hide();
            topLink.show();
        })
    });
});
