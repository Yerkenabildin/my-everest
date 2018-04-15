import Foundation

struct Log {
  private static let debugLevelKey = "debug_level_enable"
  private static let infoLevelKey = "info_level_enable"
  private static let errorLevelKey = "error_level_enable"
  private static let networkInfoLevelKey = "network_info_level_enable"
  private static let memoryInfoLevelKey = "memory_info_level_enable"

  private static var isDebugEnable: Bool {
    return ProcessInfo.processInfo.environment[debugLevelKey] != nil
  }

  private static var isErrorEnable: Bool {
    return ProcessInfo.processInfo.environment[errorLevelKey] != nil
  }

  private static var isInfoEnable: Bool {
    return ProcessInfo.processInfo.environment[infoLevelKey] != nil
  }

  private static var isNetworkInfoEnable: Bool {
    return ProcessInfo.processInfo.environment[networkInfoLevelKey] != nil
  }

  private static var isMemoryInfoEnable: Bool {
    return ProcessInfo.processInfo.environment[memoryInfoLevelKey] != nil
  }

  static func network(_ logText: CustomStringConvertible?) {
    guard let logText = logText, isNetworkInfoEnable else {
      return
    }
    print("🌐[NETWORK]: \(logText)")
  }

  static func deinitOf(_ object: Any, filePath: String = #file) {
    guard isMemoryInfoEnable else {
      return
    }
    let className = String(describing: type(of: object))
    print("💀[MEMORY]: \(className) is deinit")
  }

  static func initOf(_ object: Any, filePath: String = #file) {
    guard isMemoryInfoEnable else {
      return
    }
    let className = String(describing: type(of: object))
    print("🐣[MEMORY]: \(className) is initialized")
  }

  static func debug(_ logText: CustomStringConvertible?, functionName: String = #function, filePath: String = #file) {
    guard let logText = logText, isDebugEnable else {
      return
    }
    let header = "******** \(functionName) ********"
    let footer = header.replaceAllChars(with: "*")
    print("\n\(header)\n🔵[DEBUG]: \(logText) \n\(footer)\n")
  }

  static func error(_ logText: CustomStringConvertible?, functionName: String = #function, filePath: String = #file) {
    guard let logText = logText, isErrorEnable else {
      return
    }
    let header = "******** \(functionName) ********"
    let footer = header.replaceAllChars(with: "*")
    print("\n\(header)\n🔴[ERROR]: \(logText) \n\(footer)\n")
  }

  static func info(_ logText: CustomStringConvertible?) {
    guard let logText = logText, isInfoEnable else {
      return
    }
    print("ℹ️[INFO]: \(logText)")
  }
}
