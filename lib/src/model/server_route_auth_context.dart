class ServerRouteAuthContext {
  final String? token;

  const ServerRouteAuthContext({
    required this.token,
  });

  ServerRouteAuthContext copyWith({
    String? token,
  }) {
    return ServerRouteAuthContext(
      token: token ?? this.token,
    );
  }
}
