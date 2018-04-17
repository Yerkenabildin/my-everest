import Foundation
import RxFlow

protocol ViewModelType: Stepper, HasActivityIndicator, HasErrorTracker, HasDisposeBag {
    func bindActivityIndicator()
    func bindErrorTracker()
}

extension ViewModelType {
    func bindActivityIndicator() {
        self.activityIndicator
            .asDriver()
            .drive(onNext: { _ in
//                self?.coordinator?.execute(step: AppStep.toggleLoading(loading))
            })
            .disposed(by: disposeBag)
    }
}

extension ViewModelType {
    func bindErrorTracker() {
      self.errorTracker
        .asDriver()
        .map { PopupStep.error($0) }
        .drive(self.step)
        .disposed(by: self.disposeBag)
    }
}
