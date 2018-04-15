import Foundation
import Swinject

class Dependency {
  private var assembler: Assembler!

  var resolver: Resolver {
    return assembler.resolver
  }

  static var shared: Dependency = {
    return Dependency()
  }()

  private init() { }

  func initialize() {
    self.assembler = Assembler([ServiceAssembly(),
                                ViewModelAssembly(),
                                ViewControllerAssembly(),
                                OtherAssembly()])
  }
}
