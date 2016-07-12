jQuery(document).on 'ready page:load', ->
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next_page a').attr('href')
			if url && $(window).scrollTop() > $(document).height() - $(window).height() - 110
				$('.pagination').text("Loading...")
				$.getScript(url)
		$(window).scroll()


