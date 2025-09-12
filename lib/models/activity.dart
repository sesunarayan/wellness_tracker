import 'package:uuid/uuid.dart';

class Activity {
  final String id;
  final String title;
  final String type;
  final DateTime timestamp;
  final int durationMinutes;

  Activity({
    String? id,
    required this.title,
    required this.type,
    required this.timestamp,
    this.durationMinutes = 0,
  }) : id = id ?? const Uuid().v4();

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String?,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      timestamp: DateTime.parse(json['timestamp']),
      durationMinutes: json['durationMinutes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'type': type,
    'timestamp': timestamp.toIso8601String(),
    'durationMinutes': durationMinutes,
  };
}
