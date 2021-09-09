import 'package:meta/meta.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

import '../http/http.dart';
import '../models/models.dart';

class RemoteAuthentication {
  HttpClient httpClient;
  String url;

  RemoteAuthentication({@required this.httpClient, @required this.url});

  Future<AccountEntity> auth(AuthenticationParams params) async {
    final body = RemotheAuthenticationParams.fromDomain(params).toJson();

    try {
      final httpResponse = await httpClient.request(
        url: url,
        method: 'post',
        body: body,
      );

      return RemoteAccountModel.fromJson(httpResponse).toEntity();
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
