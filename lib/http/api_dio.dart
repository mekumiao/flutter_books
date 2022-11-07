import 'package:authentication_repository/authentication_repository.dart';
import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:dio/dio.dart';
import 'package:environment_variable/environment_variable.dart';

final _options = BaseOptions(
  baseUrl: Env.baseUrl.toString(),
  connectTimeout: Env.connectTimeout,
  receiveTimeout: Env.receiveTimeout,
  validateStatus: (statusCode) => statusCode == 200,
);

class ApiDio {
  ApiDio._({
    required AuthenticationRepository authenticationRepository,
    required AdaptResultCallback adaptResultCallback,
  })  : _auth = Dio(_options)
          ..interceptors.add(RefreshTokenInterceptor(authenticationRepository))
          ..interceptors.add(
            AddAuthorizationInterceptor(
              adaptResultCallback: adaptResultCallback,
              authenticationRepository: authenticationRepository,
            ),
          )
          ..interceptors.add(
            UnauthenticationInterceptor(authenticationRepository),
          )
          ..interceptors.add(LogInterceptor()),
        _unauth = Dio(_options)..interceptors.add(LogInterceptor());

  factory ApiDio.single({
    required AuthenticationRepository authenticationRepository,
    required AdaptResultCallback adaptResultCallback,
  }) {
    return _apiDio ??= ApiDio._(
      authenticationRepository: authenticationRepository,
      adaptResultCallback: adaptResultCallback,
    );
  }

  static ApiDio? _apiDio;

  final Dio _auth;
  final Dio _unauth;

  Dio get auth => _auth;
  Dio get unauth => _unauth;
}

/// 刷新Token拦截器
///
/// 当检测到token过期时，将尝试刷新token。
/// 如果刷新失败，将退出登录并抛出 `RefreshTokenError` 异常
class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor(this.authenticationRepository);

  final AuthenticationRepository authenticationRepository;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (authenticationRepository.shouldRefreshToken) {
      await authenticationRepository.refreshToken();
    }
    super.onRequest(options, handler);
  }
}

/// 尝试获取token，并将其添加到授权头中
///
/// 当无法获取到token时，将抛出`DioError`异常
class AddAuthorizationInterceptor extends Interceptor {
  AddAuthorizationInterceptor({
    required this.adaptResultCallback,
    required this.authenticationRepository,
  });

  final AdaptResultCallback adaptResultCallback;
  final AuthenticationRepository authenticationRepository;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await authenticationRepository.token;
    if (token?.isNotEmpty ?? false) {
      adaptResultCallback(token)
        ..removeNull()
        ..appendTo(
          headers: options.headers,
          queryParameters: options.queryParameters,
        );
      super.onRequest(options, handler);
    } else {
      handler.reject(
        DioError(
          requestOptions: options,
          error: 'No token was obtained',
        ),
      );
    }
  }
}

/// 拦截接口返回401的错误
///
/// 当拦截到接口返回的401错误时，将执行退出登录操作并且抛出`DioError`异常
class UnauthenticationInterceptor extends Interceptor {
  UnauthenticationInterceptor(this.authenticationRepository);

  final AuthenticationRepository authenticationRepository;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      authenticationRepository.logOut();
    }
    super.onError(err, handler);
  }
}

/// 日志拦截器
///
/// 显示请求日志
class LogInterceptor extends Interceptor {
  LogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Log.logger
      ..i('request: ${options.baseUrl}${options.path} ${options.method}')
      ..v(options.headers)
      ..v(options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    Log.logger
      ..i(
        'response: ${response.requestOptions.baseUrl}'
        '${response.requestOptions.path} '
        '${response.requestOptions.method},'
        '${response.statusCode}',
      )
      ..v(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Log.logger.e('dio: error:', err.error, err.stackTrace);
    super.onError(err, handler);
  }
}
