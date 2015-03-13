Checkerr
========

Check for callback errors and handle them in one line


**Exit process on error**

```javascript
var check = require('checkerr').andExitProcess;

doSomething(function(err, result)) {
	check(err);
	doActualStuff(result);
});
```

**Call a higher callback on error**
```javascript
var check = require('checkerr').andCallHigherCallback;

function mainFunction(topmostCallback) {

	doSomething(function(err, result)) {
		if(check(err, topmostCallback)) return;

		doActualStuff(result);
	});

});
```

**To mock out, with mockery e.g.**
```javascript
mockery.registerSubstitute('checkerr', 'checkerr/mock-disable');
```
