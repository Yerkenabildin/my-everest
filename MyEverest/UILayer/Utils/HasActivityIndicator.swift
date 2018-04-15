import ObjectiveC
import UIKit

fileprivate var activityIndicatorKey = "activityIndicator"

protocol HasActivityIndicator: class, AssociatedObjectStore {
    var activityIndicator: ActivityIndicator { get set }
}

extension HasActivityIndicator {
    var activityIndicator: ActivityIndicator {
        get {
            return self.associatedObject(forKey: &activityIndicatorKey, default: ActivityIndicator())
        }
        set {
            self.setAssociatedObject(newValue, forKey: &activityIndicatorKey)
        }
    }
}
