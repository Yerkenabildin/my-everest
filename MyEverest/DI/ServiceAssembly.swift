import Foundation
import Swinject

final class ServiceAssembly: Assembly {
  func assemble(container: Container) {
    container.register(GoalServiceType.self) { (_) in
      return GoalService()
    }.inObjectScope(.container)
  }
}
