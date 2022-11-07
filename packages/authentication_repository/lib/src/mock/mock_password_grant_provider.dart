import 'package:authentication_repository/src/base_authentiction.dart';
import 'package:authentication_repository/src/models/userinfo.dart';
import 'package:oauth2/oauth2.dart';

class MockPasswordGrantProvider extends PasswordGrantProvider {
  MockPasswordGrantProvider();

  factory MockPasswordGrantProvider.standard() => MockPasswordGrantProvider();

  Userinfo? _userinfo;

  @override
  Userinfo get userinfo => _userinfo ?? const Userinfo(sub: '1', name: 'name');

  @override
  Future<void> handleResourceOwnerPassword(
    String email,
    String password,
  ) async {
    if (email == 'admin') {
      _userinfo = Userinfo(name: email, sub: '1', role: ['admin', 'user']);
    } else if (email == 'gougou') {
      _userinfo = Userinfo(name: email, sub: '2', role: ['user']);
    } else {
      _userinfo = Userinfo(name: email, sub: '3');
    }
  }

  @override
  Future<void> handleUserinfo() async {}

  @override
  Credentials get credentials {
    return Credentials(
      '123123',
      refreshToken: '123123',
      idToken: '123123',
      tokenEndpoint: Uri.parse('https://localhost'),
      scopes: ['openid'],
      expiration: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  @override
  void clear() {}
}
