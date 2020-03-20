// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum L10n {
  /// Nepal: year 1976, You approach an ancient ice cave In Nepal. You just reached the summit of the mountain. There is a huge door before of you. When VoiceOver is turned on, you can go from one text to the other by touching it directly or sliding left or right with your finger. Double tap to validate or select something.
  static let chapter1Description = L10n.tr("Localizable", "chapter1_description")
  /// There are bear footprints on the floor
  static let chapter2Cq1a1 = L10n.tr("Localizable", "chapter2_cq1a1")
  /// Wolves are standing close to you
  static let chapter2Cq1a2 = L10n.tr("Localizable", "chapter2_cq1a2")
  /// There are ice spikes on the ceiling above you
  static let chapter2Cq1a3 = L10n.tr("Localizable", "chapter2_cq1a3")
  /// An eagle is on the top of an house of the hidden city
  static let chapter2Cq1a4 = L10n.tr("Localizable", "chapter2_cq1a4")
  /// 4, 2... Maybe this relates to the number of legs of the animal...
  static let chapter2Cq1h1 = L10n.tr("Localizable", "chapter2_cq1h1")
  /// After progressing into the next room, there is a water stream on your left
  static let chapter2Cq2a1 = L10n.tr("Localizable", "chapter2_cq2a1")
  /// Birds are singing around you, you find it relaxing
  static let chapter2Cq2a2 = L10n.tr("Localizable", "chapter2_cq2a2")
  /// An old owl is standing on the door
  static let chapter2Cq2a3 = L10n.tr("Localizable", "chapter2_cq2a3")
  /// BOW
  static let chapter2Cq2aa1 = L10n.tr("Localizable", "chapter2_cq2aa1")
  /// BAT
  static let chapter2Cq2aa2 = L10n.tr("Localizable", "chapter2_cq2aa2")
  /// CAT
  static let chapter2Cq2aa3 = L10n.tr("Localizable", "chapter2_cq2aa3")
  /// ARROW
  static let chapter2Cq2aa4 = L10n.tr("Localizable", "chapter2_cq2aa4")
  /// After exploring further into the mountain, You reach an old abandonned city which was probably visited by an old Nepalese civilization. There are several doors locked with a lock safe mechanism in front of you. You need to find the code of each of them based on the clues you find in the room. When VoiceOver is turned on, you can use the rotor to access the menu. Draw a circle with two fingers on screen as if you were turning a dial. You can then go from one option to the other. Continue to turn your fingers to hear about answer options, until you hear the option. Drag your finger up or down to validate.
  static let chapter2Description = L10n.tr("Localizable", "chapter2_description")
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
