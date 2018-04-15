//
//  UIViewController+Additions.swift
//  BucketList
//
//  Created by Yerkebulan Abildin on 26.04.17.
//
//

import UIKit

extension UIViewController {
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }

    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
