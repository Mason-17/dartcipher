import 'dart:io';
import 'dart:convert';

class Color {
  String? name;
  int? red;
  int? green;
  int? blue;
  String? hex;

  Color(String n, int r, int g, int b, String h) {
    name = n;
    red = r;
    green = g;
    blue = b;
    hex = h;
  }

  Color.empty() {
    name = "New Color";
    red = 0;
    green = 0;
    blue = 0;
    hex = "000000";
  }

  void rename(String newName) => name = newName;

  Color.fromJson(Map<String, dynamic> json):
    name = json['name'] as String,
    red = json['red'] as int,
    blue = json['blue'] as int,
    green = json['green'] as int;

  Map<String, dynamic> toJson() => {
    'name': name,
    'red': red,
    'green': green,
    'blue': blue,
    'hex': hex,
  };

  void save() {
    var file = File("$name.color");
    var contents = this.toJson();
    String jsonStr = jsonEncode(contents);
    file.writeAsString(jsonStr);
  }

  load () async {
    var file = File("$name.color");
    final jStr = await file.readAsString();
    final Map<String, dynamic> map = jsonDecode(jStr) as Map<String, dynamic>;

    Color.fromJson(map);
  }
}