// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {
  /// This is a Loc pipeline test
  internal static let pipelineTest = L10n.tr("Localizable", "PipelineTest")

  internal enum APIClientError {
    /// The Server returned data we weren't expecting.
    internal static let invalidResponseData = L10n.tr("Localizable", "APIClientError.invalidResponseData")
    /// The Server returned no data even though we were expecting that.
    internal static let noData = L10n.tr("Localizable", "APIClientError.noData")
    internal enum Http {
      /// An HTTP Error occurred: %@
      internal static func stringArg(_ p1: String) -> String {
        return L10n.tr("Localizable", "APIClientError.Http.stringArg", p1)
      }
    }
    internal enum Unexpected {
      /// Unexpected error: %@
      internal static func stringArg(_ p1: String) -> String {
        return L10n.tr("Localizable", "APIClientError.unexpected.stringArg", p1)
      }
    }
  }

  internal enum ChannelListViewController {
    /// Fetching Data...
    internal static let loadingText = L10n.tr("Localizable", "ChannelListViewController.loadingText")
    /// Channel List
    internal static let title = L10n.tr("Localizable", "ChannelListViewController.title")
  }

  internal enum ChannelListViewTableCellModel {
    internal enum LastWatched {
      /// Last watched: %@ ago
      internal static func stringArg(_ p1: String) -> String {
        return L10n.tr("Localizable", "ChannelListViewTableCellModel.lastWatched.stringArg", p1)
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
