class BuildMode {
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  static bool get isDebug => !isRelease;
}