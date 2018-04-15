//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 0 files.
  struct file {
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 9 images.
  struct image {
    /// Image `calendar_icon`.
    static let calendar_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "calendar_icon")
    /// Image `checkbox on`.
    static let checkboxOn = Rswift.ImageResource(bundle: R.hostingBundle, name: "checkbox on")
    /// Image `checkbox`.
    static let checkbox = Rswift.ImageResource(bundle: R.hostingBundle, name: "checkbox")
    /// Image `coins_icon`.
    static let coins_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "coins_icon")
    /// Image `color_icon`.
    static let color_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "color_icon")
    /// Image `deadline`.
    static let deadline = Rswift.ImageResource(bundle: R.hostingBundle, name: "deadline")
    /// Image `done_date`.
    static let done_date = Rswift.ImageResource(bundle: R.hostingBundle, name: "done_date")
    /// Image `pen_icon`.
    static let pen_icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "pen_icon")
    /// Image `type_Icon`.
    static let type_Icon = Rswift.ImageResource(bundle: R.hostingBundle, name: "type_Icon")
    
    /// `UIImage(named: "calendar_icon", bundle: ..., traitCollection: ...)`
    static func calendar_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.calendar_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "checkbox on", bundle: ..., traitCollection: ...)`
    static func checkboxOn(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.checkboxOn, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "checkbox", bundle: ..., traitCollection: ...)`
    static func checkbox(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.checkbox, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "coins_icon", bundle: ..., traitCollection: ...)`
    static func coins_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.coins_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "color_icon", bundle: ..., traitCollection: ...)`
    static func color_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.color_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "deadline", bundle: ..., traitCollection: ...)`
    static func deadline(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.deadline, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "done_date", bundle: ..., traitCollection: ...)`
    static func done_date(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.done_date, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "pen_icon", bundle: ..., traitCollection: ...)`
    static func pen_icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.pen_icon, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "type_Icon", bundle: ..., traitCollection: ...)`
    static func type_Icon(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.type_Icon, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 3 nibs.
  struct nib {
    /// Nib `EditGoalViewController`.
    static let editGoalViewController = _R.nib._EditGoalViewController()
    /// Nib `GoalInfoViewController`.
    static let goalInfoViewController = _R.nib._GoalInfoViewController()
    /// Nib `GoalsListViewController`.
    static let goalsListViewController = _R.nib._GoalsListViewController()
    
    /// `UINib(name: "EditGoalViewController", in: bundle)`
    static func editGoalViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.editGoalViewController)
    }
    
    /// `UINib(name: "GoalInfoViewController", in: bundle)`
    static func goalInfoViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.goalInfoViewController)
    }
    
    /// `UINib(name: "GoalsListViewController", in: bundle)`
    static func goalsListViewController(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.goalsListViewController)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
  struct reuseIdentifier {
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    /// This `R.string.infoPlist` struct is generated, and contains static references to 1 localization keys.
    struct infoPlist {
      /// Base translation: My Everest
      /// 
      /// Locales: Base, ru
      static let cfBundleDisplayName = Rswift.StringResource(key: "CFBundleDisplayName", tableName: "InfoPlist", bundle: R.hostingBundle, locales: ["Base", "ru"], comment: nil)
      
      /// Base translation: My Everest
      /// 
      /// Locales: Base, ru
      static func cfBundleDisplayName(_: Void = ()) -> String {
        return NSLocalizedString("CFBundleDisplayName", tableName: "InfoPlist", bundle: R.hostingBundle, value: "My Everest", comment: "")
      }
      
      fileprivate init() {}
    }
    
    /// This `R.string.localization` struct is generated, and contains static references to 8 localization keys.
    struct localization {
      /// Base translation: Choose deadline
      /// 
      /// Locales: Base
      static let chooseDeadline = Rswift.StringResource(key: "Choose deadline", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Complited date
      /// 
      /// Locales: Base
      static let complitedDate = Rswift.StringResource(key: "Complited date", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Create
      /// 
      /// Locales: Base
      static let create = Rswift.StringResource(key: "Create", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Deadline
      /// 
      /// Locales: Base
      static let deadline = Rswift.StringResource(key: "Deadline", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Description...
      /// 
      /// Locales: Base
      static let description = Rswift.StringResource(key: "Description...", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Goal title
      /// 
      /// Locales: Base
      static let goalTitle = Rswift.StringResource(key: "Goal title", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Group
      /// 
      /// Locales: Base
      static let group = Rswift.StringResource(key: "Group", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      /// Base translation: Value
      /// 
      /// Locales: Base
      static let value = Rswift.StringResource(key: "Value", tableName: "Localization", bundle: R.hostingBundle, locales: ["Base"], comment: nil)
      
      /// Base translation: Choose deadline
      /// 
      /// Locales: Base
      static func chooseDeadline(_: Void = ()) -> String {
        return NSLocalizedString("Choose deadline", tableName: "Localization", bundle: R.hostingBundle, value: "Choose deadline", comment: "")
      }
      
      /// Base translation: Complited date
      /// 
      /// Locales: Base
      static func complitedDate(_: Void = ()) -> String {
        return NSLocalizedString("Complited date", tableName: "Localization", bundle: R.hostingBundle, value: "Complited date", comment: "")
      }
      
      /// Base translation: Create
      /// 
      /// Locales: Base
      static func create(_: Void = ()) -> String {
        return NSLocalizedString("Create", tableName: "Localization", bundle: R.hostingBundle, value: "Create", comment: "")
      }
      
      /// Base translation: Deadline
      /// 
      /// Locales: Base
      static func deadline(_: Void = ()) -> String {
        return NSLocalizedString("Deadline", tableName: "Localization", bundle: R.hostingBundle, value: "Deadline", comment: "")
      }
      
      /// Base translation: Description...
      /// 
      /// Locales: Base
      static func description(_: Void = ()) -> String {
        return NSLocalizedString("Description...", tableName: "Localization", bundle: R.hostingBundle, value: "Description...", comment: "")
      }
      
      /// Base translation: Goal title
      /// 
      /// Locales: Base
      static func goalTitle(_: Void = ()) -> String {
        return NSLocalizedString("Goal title", tableName: "Localization", bundle: R.hostingBundle, value: "Goal title", comment: "")
      }
      
      /// Base translation: Group
      /// 
      /// Locales: Base
      static func group(_: Void = ()) -> String {
        return NSLocalizedString("Group", tableName: "Localization", bundle: R.hostingBundle, value: "Group", comment: "")
      }
      
      /// Base translation: Value
      /// 
      /// Locales: Base
      static func value(_: Void = ()) -> String {
        return NSLocalizedString("Value", tableName: "Localization", bundle: R.hostingBundle, value: "Value", comment: "")
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    struct _EditGoalViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "EditGoalViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _GoalInfoViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "GoalInfoViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    struct _GoalsListViewController: Rswift.NibResourceType {
      let bundle = R.hostingBundle
      let name = "GoalsListViewController"
      
      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [NSObject : AnyObject]? = nil) -> UIKit.UIView? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? UIKit.UIView
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let goalViewController = StoryboardViewControllerResource<GoalViewController>(identifier: "GoalViewController")
      let goalsListViewController = StoryboardViewControllerResource<UIKit.UIViewController>(identifier: "GoalsListViewController")
      let name = "Main"
      let taskViewController = StoryboardViewControllerResource<TaskViewController>(identifier: "TaskViewController")
      let tasksListViewController = StoryboardViewControllerResource<TasksListViewController>(identifier: "TasksListViewController")
      
      func goalViewController(_: Void = ()) -> GoalViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: goalViewController)
      }
      
      func goalsListViewController(_: Void = ()) -> UIKit.UIViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: goalsListViewController)
      }
      
      func taskViewController(_: Void = ()) -> TaskViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: taskViewController)
      }
      
      func tasksListViewController(_: Void = ()) -> TasksListViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: tasksListViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "done_date") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'done_date' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "calendar_icon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'calendar_icon' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "pen_icon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'pen_icon' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "color_icon") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'color_icon' is used in storyboard 'Main', but couldn't be loaded.") }
        if _R.storyboard.main().tasksListViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'tasksListViewController' could not be loaded from storyboard 'Main' as 'TasksListViewController'.") }
        if _R.storyboard.main().goalViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'goalViewController' could not be loaded from storyboard 'Main' as 'GoalViewController'.") }
        if _R.storyboard.main().goalsListViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'goalsListViewController' could not be loaded from storyboard 'Main' as 'UIKit.UIViewController'.") }
        if _R.storyboard.main().taskViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'taskViewController' could not be loaded from storyboard 'Main' as 'TaskViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
