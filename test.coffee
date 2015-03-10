#!/usr/bin/env coffee
checkerr = require './checkerr.coffee'

fakeprocess =
	exit: (code) ->
		console.error "*** Would have exited with status #{code % 256}"

checkerr.mockProcess fakeprocess

checkerr.andExitProcess null, console, 100
checkerr.andExitProcess 'A simple error happened'
checkerr.andExitProcess 'A foobar error happened', console, -12

checkResult = checkerr.andCallHigherCallback null, (err, result) ->
	console.error '(1) FAIL: should not have called the callback'

if checkResult
	console.error '(2) FAIL: should have returned false'

checkResult = checkerr.andCallHigherCallback 'an error', (err, result) ->
	unless err is 'an error'
		console.error '(3) FAIL: should have populated callback err param with \'an error\''

	if result?
		console.error '(4) FAIL: callback result should be missing'

unless checkResult
	console.error '(5) FAIL: should have returned true'

console.log '\n'
console.log 'Tests passed if no \'FAIL\' lines appeared'
