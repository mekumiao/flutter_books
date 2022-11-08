/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/book1.png
  AssetGenImage get book1 => const AssetGenImage('assets/images/book1.png');

  /// File path: assets/images/book2.png
  AssetGenImage get book2 => const AssetGenImage('assets/images/book2.png');

  /// File path: assets/images/book3.png
  AssetGenImage get book3 => const AssetGenImage('assets/images/book3.png');

  /// File path: assets/images/book4.png
  AssetGenImage get book4 => const AssetGenImage('assets/images/book4.png');

  /// File path: assets/images/book5.png
  AssetGenImage get book5 => const AssetGenImage('assets/images/book5.png');

  /// File path: assets/images/book6.png
  AssetGenImage get book6 => const AssetGenImage('assets/images/book6.png');

  /// File path: assets/images/buy_success.png
  AssetGenImage get buySuccess =>
      const AssetGenImage('assets/images/buy_success.png');

  /// File path: assets/images/ic_arrow_left.png
  AssetGenImage get icArrowLeft =>
      const AssetGenImage('assets/images/ic_arrow_left.png');

  /// File path: assets/images/ic_eyes.png
  AssetGenImage get icEyes => const AssetGenImage('assets/images/ic_eyes.png');

  /// File path: assets/images/ic_facebook.png
  AssetGenImage get icFacebook =>
      const AssetGenImage('assets/images/ic_facebook.png');

  /// File path: assets/images/ic_google.png
  AssetGenImage get icGoogle =>
      const AssetGenImage('assets/images/ic_google.png');

  /// File path: assets/images/ic_home.png
  AssetGenImage get icHome => const AssetGenImage('assets/images/ic_home.png');

  /// File path: assets/images/ic_open_book.png
  AssetGenImage get icOpenBook =>
      const AssetGenImage('assets/images/ic_open_book.png');

  /// File path: assets/images/ic_picture.png
  AssetGenImage get icPicture =>
      const AssetGenImage('assets/images/ic_picture.png');

  /// File path: assets/images/ic_search.png
  AssetGenImage get icSearch =>
      const AssetGenImage('assets/images/ic_search.png');

  /// File path: assets/images/login_cover.png
  AssetGenImage get loginCover =>
      const AssetGenImage('assets/images/login_cover.png');

  /// File path: assets/images/plaintext.png
  AssetGenImage get plaintext =>
      const AssetGenImage('assets/images/plaintext.png');

  /// File path: assets/images/splash_cover.png
  AssetGenImage get splashCover =>
      const AssetGenImage('assets/images/splash_cover.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        book1,
        book2,
        book3,
        book4,
        book5,
        book6,
        buySuccess,
        icArrowLeft,
        icEyes,
        icFacebook,
        icGoogle,
        icHome,
        icOpenBook,
        icPicture,
        icSearch,
        loginCover,
        plaintext,
        splashCover
      ];
}

class $AssetsPemsGen {
  const $AssetsPemsGen();

  /// File path: assets/pems/encryption_everywhere.pem
  String get encryptionEverywhere => 'assets/pems/encryption_everywhere.pem';

  /// File path: assets/pems/global_village_sign.pem
  String get globalVillageSign => 'assets/pems/global_village_sign.pem';

  /// List of all assets
  List<String> get values => [encryptionEverywhere, globalVillageSign];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsPemsGen pems = $AssetsPemsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
