import Foundation

func fatalError(_ error: InnerError, file: StaticString = #file, line: UInt = #line) -> Never {
  fatalError(error, file: file, line: line)
}

func fatalError(_ error: Error, file: StaticString = #file, line: UInt = #line) -> Never {
  fatalError(error.localizedDescription, file: file, line: line)
}

func unexpectedError(_ error: InnerError, file: StaticString = #file, line: UInt = #line) {
  unexpectedError(error.localizedDescription, file: file, line: line)
}

func unexpectedError(_ errorText: String, file: StaticString = #file, line: UInt = #line) {
  #if DEBUG
    fatalError(errorText, file: file, line: line)
  #else
    print(errorText)
  #endif
}
