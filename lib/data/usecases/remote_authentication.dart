import 'package:meta/meta.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';

import 'package:fordev/data/http/http.dart';

class RemoteAuthentication {
  HttpClient httpClient;
  String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<void> auth(AuthenticationParams params) async {
    final body = RemotheAuthenticationParams.fromDomain(params).toJson();

    try {
      await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}

class RemotheAuthenticationParams {
  final String email;
  final String password;
  RemotheAuthenticationParams({
    @required this.email,
    @required this.password,
  });

  factory RemotheAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemotheAuthenticationParams(email: params.email, password: params.secret);

  Map toJson() => {'email': email, 'password': password};
}
