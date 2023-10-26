class ActionData {
  late int id;
  final String device;
  final bool status;
  final DateTime time;

  ActionData(
      {required this.device, required this.status, required this.time, id}) {
    if (id != null) {
      this.id = id;
    }
  }

  ActionData copyWith({
    int? id,
    String? device,
    bool? status,
    DateTime? time,
  }) {
    return ActionData(
      id: id ?? this.id,
      device: device ?? this.device,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }

  factory ActionData.fromJson(Map<String, dynamic> json) {
    return ActionData(
      id: json['id'],
      device: json['device'],
      status: json['status'],
      time: DateTime.fromMillisecondsSinceEpoch(json['date']),
    );
  }

  Map<String, dynamic> toJson() => {
        'device': device,
        'status': status,
        'date': time.millisecondsSinceEpoch,
      };
}
