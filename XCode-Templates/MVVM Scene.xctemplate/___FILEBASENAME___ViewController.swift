import UIKit

// sourcery:autoinject = ___VARIABLE_productName:identifier___ViewModelType
final class ___FILEBASENAMEASIDENTIFIER___: BaseViewController {

    private let viewModel: ___VARIABLE_productName:identifier___ViewModelType
    init(viewModel: ___VARIABLE_productName:identifier___ViewModelType) {
        self.viewModel = viewModel
        super.init(viewModel: viewModel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func bindViewModel() {

    }

    override func bindStyles() {

    }
}
