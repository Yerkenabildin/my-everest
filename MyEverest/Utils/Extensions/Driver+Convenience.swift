import Foundation
import RxCocoa
import RxSwift

extension SharedSequence {
    public func unwrap<T>() -> SharedSequence<S, T> where E == T? {
        return self.filter { $0 != nil }.map { $0! }
    }
}
