class Ingredient {
  String? name;
  String? measurement;
  String? image;

  Ingredient({required this.name, required this.measurement, this.image});

  Ingredient.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    measurement = json['Measurement'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Name'] = name;
    data['Measurement'] = measurement;
    data['Image'] = image;
    return data;
  }
}
