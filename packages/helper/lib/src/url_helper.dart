import 'dart:convert';

class UrlHelper {
  const UrlHelper._();

  static List<int> base64UrlDecode(String cipher) {
    var source = cipher;
    source = source.replaceAll('-', '+');
    source = source.replaceAll('_', '/');
    switch (source.length % 4) {
      case 0:
        break;
      case 2:
        source += '==';
        break;
      case 3:
        source += '=';
        break;
      default:
        throw Exception('Illegal base64url String!');
    }
    return base64Decode(source);
  }
}
