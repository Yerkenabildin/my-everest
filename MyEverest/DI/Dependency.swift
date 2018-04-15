import Foundation
import Swinject

class Dependency {
  // TODO: Handle stubbing based on the `Environment`
  private var assembler: Assembler!

  var resolver: Resolver {
    return assembler.resolver
  }

  static var shared: Dependency = {
    return Dependency()
  }()

  private init() { }

  func initialize() {
    self.assembler = Assembler([ViewModelAssembly(),
                                ViewControllerAssembly(),
                                OtherAssembly()])
  }
}
