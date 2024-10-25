/**
 * @description Find all tests that call "pressActionKey"
 * @kind problem
 * @id javascript/tests-calling-pressActionKey
 * @problem.severity recommendation
 */
import javascript

/**
 * Holds if a function is a test.
 */
predicate isTest(Function test) {
  exists(CallExpr describe, CallExpr it |
    describe.getCalleeName() = "describe" and
    it.getCalleeName() = "it" and
    it.getParent*() = describe and
    test = it.getArgument(1)
  )
}

/**
 * Holds if a function calls "pressActionKey".
 */
predicate callsPressActionKey(Function func) {
  exists(CallExpr call |
    call.getCalleeName() = "pressActionKey" and
    call.getEnclosingFunction() = func
  )
}

from Function function
where isTest(function) and 
      callsPressActionKey(function)
select function, "Test function calls pressActionKey: " + function.getName()
