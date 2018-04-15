import RxDataSources

struct GoalSection {
  var items: [Item]
  var identity: String = "default"

  init(_ items: [Item]) {
    self.items = items
  }
}

extension GoalSection: AnimatableSectionModelType {
  typealias Item = Goal

  init(original: GoalSection, items: [Goal]) {
    self = original
    self.items = items
  }
}
