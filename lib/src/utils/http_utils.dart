import 'dart:io';

class HttpUtils {
  static void applyHttpOverrides({
    required bool httpsCertificatesCheckDisabled,
  }) {
    if (httpsCertificatesCheckDisabled) {
      HttpOverrides.global = _InsecureHttpOverrides();
    }
  }
}

class _InsecureHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        _,
        __,
        ___,
      ) =>
          true;
  }
}
