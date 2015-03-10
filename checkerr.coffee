# handle optional errors in callbacks in one line
process = process

module.exports =

	andExitProcess: (err, logger=console, badExitCode=-1) ->
		if err?
			logger.error(err) if typeof logger?.error is 'function'
			process.exit badExitCode

	andCallHigherCallback: (err, callback, wrapError=false) ->
		if err? and typeof callback is 'function'
			if wrapError
				err = {
					error: err
				}

			callback err

			return true

		return false

	mockProcess: (mock) ->
		process = mock
