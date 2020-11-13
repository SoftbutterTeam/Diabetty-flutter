import 'package:random_string/random_string.dart' as random;

class JournalEntry {
  String userId;
  String id;
  String journalId;
  String type;
  double recordEntry;
  String notes;
  DateTime createdAt;
  int reportUnitsIndex;

  JournalEntry(
      {this.userId,
      this.id,
      this.journalId,
      this.type,
      this.createdAt,
      this.recordEntry,
      this.notes,
      this.reportUnitsIndex}) {
    this.id = this.id ?? generateUID();
  }

  String generateUID() {
    return random.randomAlphaNumeric(6) +
        DateTime.now().microsecondsSinceEpoch.toString();
  }

  loadFromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.userId = json['userId'];
    this.journalId = json['journalId'];
    this.type = json['type'];
    this.createdAt = json['createdAt'];
    this.recordEntry = json['recordEntry'];
    this.notes = json['notes'];
    this.reportUnitsIndex = json['reportUnitsIndex'];
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': this.userId,
        'journalId': this.journalId,
        'type': this.type,
        'recordEntry': this.recordEntry,
        'notes': this.notes,
        'createdAt': this.createdAt,
        'reportUnitsIndex': this.reportUnitsIndex
      };
}
