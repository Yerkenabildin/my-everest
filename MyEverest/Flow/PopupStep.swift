import Foundation
import RxFlow

enum PopupStep: Step {
  case error(Error)
  case dismiss
}
