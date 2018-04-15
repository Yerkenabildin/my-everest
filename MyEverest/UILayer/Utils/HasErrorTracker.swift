import ObjectiveC
import UIKit

fileprivate var errorTrackerContext = "errorTracker"

protocol HasErrorTracker: class, AssociatedObjectStore {
  var errorTracker: ErrorTracker { get set }
}
extension HasErrorTracker {
  var errorTracker: ErrorTracker {
    get {
      return self.associatedObject(forKey: &errorTrackerContext, default: ErrorTracker())
    }
    set {
      self.setAssociatedObject(newValue, forKey: &errorTrackerContext)
    }
  }
}
