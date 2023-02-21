class ColorDesignModel {
  ColorDesignModel({
    this.colorName,
    this.colorNotes,
    this.red,
    this.green,
    this.blue,
    this.opacity,
  });

  final String? colorName;
  final String? colorNotes;
  final double? red;
  final double? green;
  final double? blue;
  final double? opacity;

  factory ColorDesignModel.fromJson(Map<String, dynamic> json) =>
      ColorDesignModel(
        colorName: json['colorName'],
        colorNotes: json['colorNotes'],
        red: json['red'],
        green: json['green'],
        blue: json['blue'],
        opacity: json['opacity'],
      );

  Map<String, dynamic> toJson() => {
        'colorName': colorName,
        'colorNotes': colorNotes,
        'red': red,
        'green': green,
        'blue': blue,
        'opacity': opacity,
      };
}
