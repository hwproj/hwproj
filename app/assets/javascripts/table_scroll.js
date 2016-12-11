jQuery(document).on('ready page:load',function() {
    $("#course_table").bind('mousewheel DOMMouseScroll', function(event) {
        var delta = (event.originalEvent.wheelDelta ? event.originalEvent.wheelDelta / 120 : event.originalEvent.detail / -3);
        $('#course_table').animate({
            scrollLeft: '+=' + delta * 30
        }, 1);
        event.preventDefault();
    });
});