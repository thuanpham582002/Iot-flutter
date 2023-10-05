class ActionData {
  late int id;
  final bool statusLed;
  final bool statusFan;
  final DateTime time;

  ActionData(
      {required this.statusLed,
      required this.statusFan,
      required this.time,
      id});

  factory ActionData.fromJson(Map<String, dynamic> json) {
    return ActionData(
      id: json['id'],
      statusLed: json['statusLed'],
      statusFan: json['statusFan'],
      time: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'statusLed': statusLed,
        'statusFan': statusFan,
        'date': time.toString(),
      };
}
