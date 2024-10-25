/**
 * @description Find all functions longer than 10 lines in JavaScript or TypeScript test files
 * @kind problem
 * @id javascript/functions-longer-than-ten-lines.ql
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
 * Holds if a function is longer than 10 lines.
 */
predicate isLongFunction(Function func) {
  func.getNumLines() > 10
}

from Function function
where isTest(function) and 
      isLongFunction(function)
select function, "Test function is longer than 10 lines: " + function.getName()

