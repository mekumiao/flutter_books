import 'dart:convert';
import 'dart:io';

import 'package:booksapp/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:helper/helper.dart';

class SecurityContextLoader {
  SecurityContextLoader._();

  static SecurityContext get context => SecurityContext.defaultContext;

  static Future<void> ensureInitialized() async {
    if (Device.isMobile) {
      SecurityContext.defaultContext.setTrustedCertificatesBytes(
        utf8.encode(
          [
            await rootBundle.loadString(Assets.pems.globalVillageSign),
            await rootBundle.loadString(Assets.pems.encryptionEverywhere),
          ].join(),
        ),
      );
    }
  }
}
