class TimeSlots {
  final String endTime;
  final String slotName;
  final String slotUID;
  final String startTime;

  TimeSlots({
    required this.endTime,
    required this.slotName,
    required this.slotUID,
    required this.startTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'endTime': endTime,
      'slotName': slotName,
      'slotUID': slotUID,
      'startTime': startTime,
    };
  }

  factory TimeSlots.fromMap(Map<String, dynamic> map) {
    return TimeSlots(
      endTime: map['endTime'],
      slotName: map['slotName'],
      slotUID: map['slotUID'],
      startTime: map['startTime'],
    );
  }
}
