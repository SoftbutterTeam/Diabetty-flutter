import 'package:diabetty/models/journal/journal_entry.model.dart';

class Journal {
  final String userId = 'user';
  String id;
  String name;
  int reportUnitsIndex;
  List<JournalEntry> journalEntries = [];
  DateTime updatedAt;
  Journal({this.id, this.name, this.reportUnitsIndex, this.journalEntries});

  loadFromJson(Map<String, dynamic> json) {
    this.id ??= json['id'];
    this.name = json['name'];
    this.reportUnitsIndex = json['reportUnitsIndex'];
    this.updatedAt =
        DateTime.parse(json['updatedAt'] ?? DateTime.now().toString());
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': this.userId,
        'name': this.name,
        'reportUnitsIndex': this.reportUnitsIndex,
      };

  List<JournalEntry> journalEntriesFromJson(List<dynamic> json) {
    List<JournalEntry> journalEntries = List();
    if (json == null || json.length == 0) return journalEntries ?? [];
    for (dynamic j in json) {
      Map<String, dynamic> entryJson = new Map<String, dynamic>.from(j);
      JournalEntry journalEntry = JournalEntry()..loadFromJson(entryJson);
      journalEntries.add(journalEntry);
    }
    return journalEntries ?? [];
  }
}
