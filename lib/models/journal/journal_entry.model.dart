import 'package:diabetty/models/journal/journal.model.dart';
import 'package:random_string/random_string.dart' as random;

class JournalEntry {
  final String userId = 'user';
  String id;
  String journalId;
  double recordEntry;
  String title;
  String notes;
  DateTime date;
  DateTime createdAt;
  int reportUnitsIndex;
  int recordNo;

  get isNotesType => notes != null;

  JournalEntry(
      {this.id,
      this.journalId,
      this.createdAt,
      this.recordEntry,
      this.title,
      this.notes,
      this.date,
      this.reportUnitsIndex,
      this.recordNo}) {
    //this.id = this.id; ?? generateUID();
  }

  JournalEntry.generated({Journal journal}) {
    journalId = journal.id;
    reportUnitsIndex = journal.reportUnitsIndex;
    date = DateTime.now();
  }

  String generateUID() {
    return random.randomAlphaNumeric(6) +
        DateTime.now().microsecondsSinceEpoch.toString();
  }

  loadFromJson(Map<String, dynamic> json) {
    this.id ??= json['id'];
    this.journalId = json['journalId'];
    this.date = DateTime.parse(json['date']);
    this.createdAt = DateTime.parse(json['createdAt']);
    this.recordEntry = json['recordEntry'];
    this.title = json['title'];
    this.notes = json['notes'];
    this.reportUnitsIndex = json['reportUnitsIndex'];
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': this.userId,
        'journalId': this.journalId,
        'recordEntry': this.recordEntry,
        'title': this.title,
        'notes': this.notes,
        'createdAt': this.createdAt.toString(),
        'date': this.date.toString(),
        'reportUnitsIndex': this.reportUnitsIndex
      };
}
