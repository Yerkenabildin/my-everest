//
//  CascadeFlow.swift
//  MyEverest
//
//  Created by yerke on 17/04/2018.
//  Copyright © 2018 abild.in. All rights reserved.
//

import Foundation
import RxFlow

extension Flow {
  func cascade(step: Step) -> NextFlowItems {
    switch step {
    case is PopupStep:
      return navigateToPopup(step: step)
    default:
      return .none
    }
  }

  private func navigateToPopup(step: Step) -> NextFlowItems {
    guard let viewController = self.root as? UIViewController else {
      return .none
    }
    let popupFlow = PopupFlow(with: viewController)
    let flowItem = NextFlowItem(nextPresentable: popupFlow,
                                nextStepper: OneStepper(withSingleStep: step))
    return NextFlowItems.one(flowItem: flowItem)
  }
}
