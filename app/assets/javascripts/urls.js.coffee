# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

append_url = ( url ) ->
	$( '#url-container' ).prepend ( "<li>" + url + "</li>" )

send_url = (url) ->
	$.ajax '/urls', type: 'POST',  dataType: 'JSON', data: { url: { url: url } }
	.done (data, textStatus, jqXHR) ->
		if data[ 'url' ] != null
			append_url data[ 'url' ]
	.fail (jqXHR, textStatus, errorThrown) ->
		if jqXHR.status > 0
			alert "AJAX Error: #{jqXHR.responseText}"
		else
			ajaxCall = ->
				send_url(url)
			setTimeout( ajaxCall, 15000 )

$ ->
	$form = $( '#url-input form' )
	http_pref = "http://"
	www_pref = "www."

	# should be little more complicated, but it sufficient for the example
	url_pattern = /^((([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)+([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]))($|\/)/

	$form.submit ( event ) ->
		new_url = $form.find( '#url_url' ).val()
		new_url = new_url.substring( http_pref.length, new_url.length ) if new_url.substring( 0, http_pref.length ) == http_pref
		new_url = new_url.substring( www_pref.length, new_url.length ) if new_url.substring( 0, www_pref.length ) == www_pref
		matches = url_pattern.exec new_url
		if matches != null
			send_url matches[ 1 ]
		else
			alert 'Error! Malformed url!'
		$form.find( '#url_url' ).val('')
		event.preventDefault
		return false