import Foundation
import CoreData

class Task {
  let id: String
  var name: String?
  var note: String?
  var doneDate: Date?
  var dueDate: Date?
  var isComplete = true

  init(id: String) {
    self.id = id
  }
}
