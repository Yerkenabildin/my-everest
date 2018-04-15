import Foundation
import RxDataSources

struct Goal {
  let id: String
  var name: String?
  var note: String?
  var color: UIColor?
  var doneDate: Date?
  var dueDate: Date?
  var isComplete = false
  var tasks: [Task]?

  init(id: String) {
    self.id = id
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
