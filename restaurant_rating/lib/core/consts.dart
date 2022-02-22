class Constants {
  static final Constants instance = Constants._private();
  Constants._private();
  factory Constants() => instance;

  final apiUrl = "";
  // final apiUrl = "http://localhost:3000"; //locaolhost
  // final apiUrl = "http://10.0.2.2:3000"; //android

  String get splashLogo => _toJson('splash');
  List<String> languages = ['Türkçe', 'English'];

  String _toJson(String name) => 'assets/json/$name.json';
  Uri toApi(String url) => Uri.parse(apiUrl + url);
}
