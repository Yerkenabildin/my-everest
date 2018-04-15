//
//  OtherAssembly.swift
//  GoBiker-V2
//
//  Created by Nour Helmi on 23/02/2018.
//  Copyright © 2018 Nour Helmi. All rights reserved.
//

import Foundation
import Swinject

final class OtherAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CoordinatorType.self) { (_) in
            return AppCoordinator()
        }.inObjectScope(.container)
    }
}
