import 'package:json_annotation/json_annotation.dart';

part 'server_route_headers.g.dart';

@JsonSerializable()
class ServerRouteHeaders {
  final String? token;

  const ServerRouteHeaders({
    required this.token,
  });

  factory ServerRouteHeaders.fromJson(Map<String, Object?> json) =>
      _$ServerRouteHeadersFromJson(json);

  Map<String, Object?> toJson() => _$ServerRouteHeadersToJson(this);
}
