class BaseConfigurationService {
  final bool httpsCertificatesCheckDisabled;
  final bool corsEnabled;
  final int serverPort;

  const BaseConfigurationService({
    required this.httpsCertificatesCheckDisabled,
    required this.corsEnabled,
    required this.serverPort,
  });
}
