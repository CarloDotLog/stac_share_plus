import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';
import 'package:stac_framework/stac_framework.dart';

class ShareActionParser extends StacActionParser<ShareActionModel> {
  @override
  String get actionType => "share";

  @override
  ShareActionModel getModel(StacAction json) => ShareActionModel.fromJson(json["data"]);

  @override
  FutureOr onCall(BuildContext context, ShareActionModel model) {
    return SharePlus.instance.share(model.toShareParams());
  }
}

extension ShareParamsExtension on ShareParams {
  ShareParams copyWith({
    String? text,
    String? title,
    String? subject,
    XFile? previewThumbnail,
    Rect? sharePositionOrigin,
    Uri? uri,
    List<XFile>? files,
    List<String>? fileNameOverrides,
    bool? downloadFallbackEnabled,
    bool? mailToFallbackEnabled,
  }) {
    return ShareParams(
      text: text ?? this.text,
      title: title ?? this.title,
      subject: subject ?? this.subject,
      previewThumbnail: previewThumbnail ?? this.previewThumbnail,
      sharePositionOrigin: sharePositionOrigin ?? this.sharePositionOrigin,
      uri: uri ?? this.uri,
      files: files ?? this.files,
      fileNameOverrides: fileNameOverrides ?? this.fileNameOverrides,
      downloadFallbackEnabled:
          downloadFallbackEnabled ?? this.downloadFallbackEnabled,
      mailToFallbackEnabled:
          mailToFallbackEnabled ?? this.mailToFallbackEnabled,
    );
  }
}

class ShareActionModel {
  // This class model represents the data associated with the action of sharing content with the compatible apps on the device.
  /// The text to share
  ///
  /// Cannot be provided at the same time as [uri],
  /// as the share method will use one or the other.
  ///
  /// Can be used together with [files],
  /// but it depends on the receiving app if they support
  /// loading files and text from a share action.
  /// Some apps only support one or the other.
  ///
  /// * Supported platforms: All
  final String? text;

  /// Used as share sheet title where supported
  ///
  /// Provided to Android Intent.createChooser as the title,
  /// as well as, EXTRA_TITLE Intent extra.
  ///
  /// Provided to web Navigator Share API as title.
  ///
  /// * Supported platforms: All
  final String? title;

  /// Used as email subject where supported (e.g. EXTRA_SUBJECT on Android)
  ///
  /// When using the email fallback, this will be the subject of the email.
  ///
  /// * Supported platforms: All
  final String? subject;

  /// Preview thumbnail
  ///
  /// TODO: https://github.com/fluttercommunity/plus_plugins/pull/3372
  ///
  /// * Supported platforms: Android
  ///   Parameter ignored on other platforms.
  //final XFile? previewThumbnail;

  /// The optional [sharePositionOrigin] parameter can be used to specify a global
  /// origin rect for the share sheet to popover from on iPads and Macs. It has no effect
  /// on other devices.
  ///
  /// * Supported platforms: iPad and Mac
  ///   Parameter ignored on other platforms.
  //final Rect? sharePositionOrigin;

  /// Share a URI.
  ///
  /// On iOS, it will trigger the iOS system to fetch the html page
  /// (if available), and the website icon will be extracted and displayed on
  /// the iOS share sheet.
  ///
  /// On other platforms it behaves like sharing text.
  ///
  /// Cannot be used in combination with [text].
  ///
  /// * Supported platforms: iOS, Android
  ///   Falls back to sharing the URI as text on other platforms.
  final Uri? uri;

  /// Share multiple files, can be used in combination with [text]
  ///
  /// Android supports all natively available MIME types (wildcards like image/*
  /// are also supported) and it's considered best practice to avoid mixing
  /// unrelated file types (eg. image/jpg & application/pdf). If MIME types are
  /// mixed the plugin attempts to find the lowest common denominator. Even
  /// if MIME types are supplied the receiving app decides if those are used
  /// or handled.
  ///
  /// On iOS image/jpg, image/jpeg and image/png are handled as images, while
  /// every other MIME type is considered a normal file.
  ///
  ///
  /// * Supported platforms: Android, iOS, Web, recent macOS and Windows versions
  ///   Throws an [UnimplementedError] on other platforms.
  //final List<XFile>? files;

  /// Override the names of shared files.
  ///
  /// When set, the list length must match the number of [files] to share.
  /// This is useful when sharing files that were created by [`XFile.fromData`](https://github.com/flutter/packages/blob/754de1918a339270b70971b6841cf1e04dd71050/packages/cross_file/lib/src/types/io.dart#L43),
  /// because name property will be ignored by  [`cross_file`](https://pub.dev/packages/cross_file) on all platforms except on web.
  ///
  /// * Supported platforms: Same as [files]
  ///   Ignored on platforms that don't support [files].
  //final List<String>? fileNameOverrides;

  /// Whether to fall back to downloading files if [share] fails on web.
  ///
  /// * Supported platforms: Web
  ///   Parameter ignored on other platforms.
  //final bool downloadFallbackEnabled;

  /// Whether to fall back to sending an email if [share] fails on web.
  ///
  /// * Supported platforms: Web
  ///   Parameter ignored on other platforms.
  //final bool mailToFallbackEnabled;

  ShareActionModel({
    this.text,
    this.title,
    this.subject,
    // this.previewThumbnail,
    //this.sharePositionOrigin,
    this.uri,
    //this.files,
    // this.fileNameOverrides,
    // this.downloadFallbackEnabled,
    // this.mailToFallbackEnabled,
  });

  /// Creates a [ShareActionModel] instance from a JSON map.
  ///
  /// Expects a map containing keys such as 'text', 'title', 'subject', and optionally 'uri'.
  factory ShareActionModel.fromJson(Map<String, dynamic> json) {
    return ShareActionModel(
      text: json['text'] as String?,
      title: json['title'] as String?,
      subject: json['subject'] as String?,
      //previewThumbnail: json['previewThumbnail'],
      //sharePositionOrigin: json['sharePositionOrigin'] as Rect?,
      uri: (json['uri'] is String && json['uri'] != null)
          ? Uri.tryParse(json['uri'] as String)
          : null,
      //files: json['files'] as List<XFile>?,
      //fileNameOverrides: json['fileNameOverrides'],
      //downloadFallbackEnabled: json['downloadFallbackEnabled'],
      //mailToFallbackEnabled: json['mailToFallbackEnabled'],
    );
  }

  factory ShareActionModel.fromShareParams(ShareParams params) {
    return ShareActionModel(
      text: params.text,
      title: params.title,
      subject: params.subject,
      //previewThumbnail: params.previewThumbnail,
      //sharePositionOrigin: params.sharePositionOrigin,
      uri: params.uri,
      //files: params.files,
      //fileNameOverrides: params.fileNameOverrides,
      //downloadFallbackEnabled: params.downloadFallbackEnabled,
      //mailToFallbackEnabled: params.mailToFallbackEnabled,
    );
  }

  ShareParams toShareParams() {
    return ShareParams(
      text: text,
      title: title,
      subject: subject,
      //previewThumbnail: previewThumbnail,
      //sharePositionOrigin: sharePositionOrigin,
      //downloadFallbackEnabled: downloadFallbackEnabled,
      //mailToFallbackEnabled: mailToFallbackEnabled,
      uri: uri,
      //files: files,
      //fileNameOverrides: fileNameOverrides,
    );
  }
}
