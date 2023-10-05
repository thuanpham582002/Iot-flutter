class DHT11Data {
  final int id;
  final double temperature;
  final double humidity;
  final DateTime time;

  DHT11Data({required this.id, required this.temperature, required this.humidity, required this.time});

  factory DHT11Data.fromJson(Map<String, dynamic> json) {
    return DHT11Data(
      id: json['id'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      time: DateTime.parse(json['date']),
    );
  }

}


