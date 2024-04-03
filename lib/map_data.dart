class MapData {
  final String name;
  final Map<String, dynamic> data;

  MapData(this.name, this.data);

  // Encode to JSON for SharedPreferences
  Map<String, dynamic> toJson() => {'name': name, 'data': data};

  // Decode from JSON for SharedPreferences
  factory MapData.fromJson(Map<String, dynamic> json) =>
      MapData(json['name'] as String, json['data'] as Map<String, dynamic>);
}
