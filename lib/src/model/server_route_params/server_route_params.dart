import 'package:gentle_server/src/model/index.dart';

abstract class ServerRouteParams {
  factory ServerRouteParams.fromParamsList(Iterable<String> params) {
    switch (params.length) {
      case 0:
        return const ServerEmptyRouteParams();
      case 1:
        return ServerRouteParams1(param1: params.first);
      case 2:
        return ServerRouteParams2(
          param1: params.first,
          param2: params.elementAt(1),
        );
      case 3:
        return ServerRouteParams3(
          param1: params.first,
          param2: params.elementAt(1),
          param3: params.elementAt(2),
        );
      case 4:
        return ServerRouteParams4(
          param1: params.first,
          param2: params.elementAt(1),
          param3: params.elementAt(2),
          param4: params.elementAt(3),
        );
      case 5:
        return ServerRouteParams5(
          param1: params.first,
          param2: params.elementAt(1),
          param3: params.elementAt(2),
          param4: params.elementAt(3),
          param5: params.elementAt(4),
        );
      default:
        throw Exception('Invalid number of params');
    }
  }
}
