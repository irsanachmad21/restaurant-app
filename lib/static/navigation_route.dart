enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail"),
  settingsRoute("/settings");

  const NavigationRoute(this.name);
  final String name;
}
