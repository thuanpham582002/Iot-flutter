class DHT11Data {
  final int id;
  final double temperature;
  final double humidity;
  final double lux;
  final DateTime time;

  DHT11Data(
      {required this.id,
      required this.temperature,
      required this.humidity,
      required this.lux,
      required this.time});

  factory DHT11Data.fromJson(Map<String, dynamic> json) {
    return DHT11Data(
      id: json['id'] ?? 0,
      temperature: json['temperature'] ?? 0.0,
      humidity: json['humidity'] ?? 0.0,
      lux: json['lux'] ?? 0.0,
      time: DateTime.fromMillisecondsSinceEpoch(json['time']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'temperature': temperature,
      'humidity': humidity,
      'lux': lux,
      'time': time.microsecondsSinceEpoch
    };
  }
}
