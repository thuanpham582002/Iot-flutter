class DHT11Data {
  final int id;
  final double temperature;
  final double humidity;
  final double lux;
  final double dust;
  final DateTime time;

  DHT11Data(
      {required this.id,
      required this.temperature,
      required this.humidity,
      required this.lux,
      required this.time,
      required this.dust});

  factory DHT11Data.fromJson(Map<String, dynamic> json) {
    return DHT11Data(
      id: json['id'] ?? 0,
      temperature: json['temperature'] ?? 0.0,
      humidity: json['humidity'] ?? 0.0,
      lux: json['lux'] ?? 0.0,
      dust: json['dust'] ?? 0.0,
      time: DateTime.fromMillisecondsSinceEpoch(json['time']),
    );
  }

  factory DHT11Data.fromJsonArduno(Map<String, dynamic> json) {
    return DHT11Data(
      id: json['id'] ?? 0,
      temperature: json['temperature'] ?? 0.0,
      humidity: json['humidity'] ?? 0.0,
      lux: json['lux'] ?? 0.0,
      dust: json['dust'] ?? 0.0,
      time: DateTime.fromMillisecondsSinceEpoch(json['time'] * 1000),
    );
  }

  DHT11Data copyWith({
    int? id,
    double? temperature,
    double? humidity,
    double? lux,
    double? dust,
    DateTime? time,
  }) {
    return DHT11Data(
      id: id ?? this.id,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      lux: lux ?? this.lux,
      dust: dust ?? this.dust,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'temperature': temperature,
      'humidity': humidity,
      'lux': lux,
      'dust': dust,
      'time': time.millisecondsSinceEpoch
    };
  }
}
