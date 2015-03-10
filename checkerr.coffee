# handle optional errors in callbacks in one line
process = process

module.exports =
	# Usage:
	# var check = require('check').andExitProcess
	# doSomething(function(err, result)) {
	#	check(err);
	#	doActualStuff(result);
	# }
	andExitProcess: (err, logger=console, badExitCode=-1) ->
		if err?
			logger.error(err) if typeof logger?.error is 'function'
			process.exit badExitCode

	# Usage:
	# var check = require('check').andCallHigherCallback
	# function mainFunction(topmostCallback) {
	#	doSomething(function(err, result)) {
	#		if(check(err, topmostCallback)) return;
	#		doActualStuff(result);
	#	}
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
