// ignore: one_member_abstracts
import 'package:gentle_server/src/server_route.dart';

abstract class ServerRouter<T> {
  T create({
    required List<ServerRoute> routes,
  });
}
