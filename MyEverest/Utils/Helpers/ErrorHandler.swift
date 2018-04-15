import Foundation

func fatalError(_ error: MyError, file: StaticString = #file, line: UInt = #line) -> Never {
  fatalError(error.localizedDescription, file: file, line: line)
}

func unexpectedError(_ error: MyError, file: StaticString = #file, line: UInt = #line) {
  unexpectedError(error.localizedDescription, file: file, line: line)
}

func unexpectedError(_ errorText: String, file: StaticString = #file, line: UInt = #line) {
  #if DEBUG
    fatalError(errorText, file: file, line: line)
  #else
    print(errorText)
  #endif
}
