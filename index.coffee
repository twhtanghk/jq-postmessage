shortid = require 'shortid'

ret = (window, $) ->
	id = null
	last_cb = null
	last_hash = document.location.hash 
	
	$.postMessage = (message, target_url, target = window.parent) ->
		if !target_url
			return
		
		message = typeof message == 'string' ? message : $.param(message)
		
		if window.postMessage
			target.postMessage message, target_url.replace /([^:]+:\/\/[^\/]+).*/, '$1'
		else
			target.location = target_url.replace /#.*$/, "##{shortid.generate()}&#{message}"
			
	$.receiveMessage = (callback, source_origin = null, delay = 100) ->
		bind = (cb) ->
			if cb
				last_cb = cb
				if window.postMessage
					if window.addEventListener
						window.addEventListener 'message', cb
					else
						window.attachEvent 'onmessage', cb
				else
					hashChange = ->
						hash = document.location.hash
						re = /^#?\d+&/
						if hash != last_hash and re.test(hash)
							last_hash = hash
							cb data: hash.replace( re, '' )
					id = setInterval hashChange, delay
		
		unbind = ->
			if last_cb
				if window.postMessage
					if window.removeEventListener
						window.removeEventListener 'message', last_cb
					else
						window.detachEvent 'onmessage', last_cb
				else
					if id
						clearInterval id
						
		if callback
			cb = (e) ->
				if (typeof source_origin == 'string' and e.origin != source_origin) or ($.isFunction(source_origin) and source_origin(e.origin) == false)
					return false
				else
					callback(e)
			unbind()
			bind(cb)
		else
			unbind()
			
ret(window, window.$)