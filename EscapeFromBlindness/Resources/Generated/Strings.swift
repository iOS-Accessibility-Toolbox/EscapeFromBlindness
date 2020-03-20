// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// Nepal: year 1976, You approach an ancient ice cave In Nepal. You just reached the summit of the mountain. There is a huge door before of you. When VoiceOver is turned on, you can go from one text to the other by touching it directly or sliding left or right with your finger. Double tap to validate or select something.
  static let chapter1Description = L10n.tr("Localizable", "chapter1_description")
  /// You are in front of a huge door, what do you do?
  static let cq1 = L10n.tr("Localizable", "cq1")
  /// Inspect the surface
  static let cq1a1 = L10n.tr("Localizable", "cq1a1")
  /// Try to find some opening mechanism on both sides of the door
  static let cq1a2 = L10n.tr("Localizable", "cq1a2")
  /// Climb the mountain
  static let cq1a3 = L10n.tr("Localizable", "cq1a3")
  /// Your walk in an awkward silence; the ground collapses underneath your feet; you just fell into a trap with spikes around you, what do you do?
  static let cq2 = L10n.tr("Localizable", "cq2")
  /// Try to climb back
  static let cq2a1 = L10n.tr("Localizable", "cq2a1")
  /// Wait
  static let cq2a2 = L10n.tr("Localizable", "cq2a2")
  /// Inspect the spikes
  static let cq2a3 = L10n.tr("Localizable", "cq2a3")
  /// You made your way out of the trap; there is a bridge in front of you, a large hole is beneath, what do you do?
  static let cq3 = L10n.tr("Localizable", "cq3")
  /// Walk carefully across the bridge
  static let cq3a1 = L10n.tr("Localizable", "cq3a1")
  /// Try to find another way along the cliff
  static let cq3a2 = L10n.tr("Localizable", "cq3a2")
  /// Look at the ceiling
  static let cq3a3 = L10n.tr("Localizable", "cq3a3")
  /// You managed to reach the other side of the bridge, you look behind and congratulate yourself for your progress; you hear some weird sound, bats are chasing you! What do you do?
  static let cq4 = L10n.tr("Localizable", "cq4")
  /// Run as far as you can deeper in the cave
  static let cq4a1 = L10n.tr("Localizable", "cq4a1")
  /// Try to activate the lever on your right
  static let cq4a2 = L10n.tr("Localizable", "cq4a2")
  /// Fight the bats with your hat
  static let cq4a3 = L10n.tr("Localizable", "cq4a3")
  /// Ok
  static let ok = L10n.tr("Localizable", "ok")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension L10n {
  fileprivate static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
