import Foundation
import RxSwift

enum AppStep: CoordinatorStepType {
    case loading
    case presentError(Error)
}

enum ObservableAppStep<R>: ObservableCoordinatorStepType {
    typealias Result = R
    case presentAlert(title: String?,
      message: String?,
      preferredStyle: UIAlertControllerStyle,
      actions: [RxAlertAction<R>])
    case presentImagePicker
}
