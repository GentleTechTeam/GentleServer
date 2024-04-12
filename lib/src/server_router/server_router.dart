import 'package:gentle_server/src/server_route.dart';

// ignore: one_member_abstracts
abstract class ServerRouter<T> {
  T create({
    required List<ServerRoute> routes,
  });
}
