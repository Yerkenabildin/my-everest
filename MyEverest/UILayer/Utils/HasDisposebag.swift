import RxSwift

fileprivate var disposeBagKey = "disposeBagKey"

protocol HasDisposeBag: class, AssociatedObjectStore {
    var disposeBag: DisposeBag { get }
}

extension HasDisposeBag {
    var disposeBag: DisposeBag {
        get {
            return self.associatedObject(forKey: &disposeBagKey, default: DisposeBag())
        }
        set {
            self.setAssociatedObject(newValue, forKey: &disposeBagKey)
        }
    }
}
