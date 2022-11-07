import 'package:authentication_repository/src/models/models.dart';
import 'package:environment_variable/environment_variable.dart';

const clientId = 'booksapp';
const clientSecret = 'sa123123';
const httpServerPort = 45625;

const scopes = <Scope>[
  Scope(name: 'openid', isRequired: true),
  Scope(name: 'profile', isRequired: false),
  Scope(name: 'roles', isRequired: false),
  Scope(name: 'offline_access', isRequired: false),
];

const _authority = 'https://sts.id4.net';
const _accountRegister = 'https://sts.id4.net/Account/Register';
const _authorizationEndpoint = 'https://sts.id4.net/connect/authorize';
const _tokenEndpoint = 'https://sts.id4.net/connect/token';
const _userinfoEndpoint = 'https://sts.id4.net/connect/userinfo';
const _endSessionEndpoint = 'https://sts.id4.net/connect/endsession';
const _revocationEndpoint = 'https://sts.id4.net/connect/revocation';
const _redirectUrl = 'com.wang.booksapp://oauth2redirect';
const _redirectUrlDev = 'com.wang.booksapp.dev://oauth2redirect';
const _redirectUrlStg = 'com.wang.booksapp.stg://oauth2redirect';
const _redirectUrlForWindows = 'http://localhost:$httpServerPort';

final authority = Uri.parse(_authority);
final accountRegister = Uri.parse(_accountRegister);
final authorizationEndpoint = Uri.parse(_authorizationEndpoint);
final tokenEndpoint = Uri.parse(_tokenEndpoint);
final userinfoEndpoint = Uri.parse(_userinfoEndpoint);
final endSessionEndpoint = Uri.parse(_endSessionEndpoint);
final revocationEndpoint = Uri.parse(_revocationEndpoint);
final redirectUrlForWindows = Uri.parse(_redirectUrlForWindows);
final redirectUrlForAndroid = Env.isDevelopment
    ? Uri.parse(_redirectUrlDev)
    : Env.isStaging
        ? Uri.parse(_redirectUrlStg)
        : Uri.parse(_redirectUrl);
