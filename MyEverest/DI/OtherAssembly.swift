import Foundation
import Swinject

final class OtherAssembly: Assembly {
  func assemble(container: Container) {
    container.register(CoordinatorType.self) { (_) in
      return AppCoordinator()
    }.inObjectScope(.container)
  }
}
