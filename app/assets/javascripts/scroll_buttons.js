jQuery(document).on('ready page:load page:restore', function() {
    var windowScrollCoordinates = 0;
    jQuery.fn.extend({
        linkWidth: function() {
            var width = jQuery(window).width() / 40;
            if (width < 15) {
                return false;
            } else {
                $(this).css({
                    'padding-right': width,
                    'padding-left': width
                });
                return true;
            }
        }
    });

    jQuery.fn.extend({
        updateLink: function(coordinate) {
            if ($(window).scrollTop() >= coordinate && $(this).linkWidth()) {
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

        $(window).resize(function() {
            if ($(window).scrollTop() == 0) {
                predLink.updateLink(0);
            } else {
                topLink.updateLink(50);
            }
        });

        $(window).scroll(function() {
          if ($(window).scrollTop() == 0) {
              predLink.updateLink(0);
          } else {
              if (predLink.is(":visible")) {
                predLink.fadeOut(300);
              }
              topLink.updateLink(50);
          }
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
