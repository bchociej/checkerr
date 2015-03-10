# handle optional errors in callbacks in one line
p = process

module.exports = do ->

	andExitProcess: (err, logger=console, badExitCode=-1) ->
		if err?
			logger.error(err) if typeof logger?.error is 'function'
			p.exit badExitCode

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
		p = mock
