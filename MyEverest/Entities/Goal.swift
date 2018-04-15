import Foundation
import RxDataSources

struct Goal {
  var id: String = ""
  var name: String?
  var note: String?
  var colorIndex = 0
  var doneDate: Date?
  var dueDate: Date?
  var isComplete = true
  var tasks: [Task]?

  var color: MaterialColor? {
    get {
      return MaterialColor(rawValue: Int(self.colorIndex))
    }
    set {
      guard let rawValue = newValue?.rawValue else {
        return
      }
      self.colorIndex = rawValue
    }
  }
}

// MARK: - RxDataSource
extension Goal: Equatable {
  static func == (lhs: Goal, rhs: Goal) -> Bool {
    return lhs.id == rhs.id
  }
}

// MARK: - RxDataSource
extension Goal: IdentifiableType {

  typealias Identity = String

  var identity: Identity {
    return self.id
  }
}
