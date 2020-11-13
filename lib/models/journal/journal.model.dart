import 'package:diabetty/models/journal/journal_entry.model.dart';

class Journal {
  String userId;
  String id;
  String name;
  int reportUnitsIndex;
  List<JournalEntry> journalEntries;
  Journal(
      {this.userId,
      this.id,
      this.name,
      this.reportUnitsIndex,
      this.journalEntries});

  loadFromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.userId = json['userId'];
    this.name = json['name'];
    this.reportUnitsIndex = json['reportUnitsIndex'];
    this.journalEntries = journalEntriesFromJson(json['journalEntries']);
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': this.userId,
        'name': this.name,
        'reportUnitsIndex': this.reportUnitsIndex,
        'journalEntries': mapJson(this.journalEntries),
      };

  List<JournalEntry> journalEntriesFromJson(List<dynamic> json) {
    List<JournalEntry> journalEntries = List();
    if (json == null || json.length == 0) return journalEntries;
    for (dynamic j in json) {
      Map<String, dynamic> entryJson = new Map<String, dynamic>.from(j);
      JournalEntry journalEntry = JournalEntry()..loadFromJson(entryJson);
      journalEntries.add(journalEntry);
    }
    return journalEntries;
  }

  List<Map<String, dynamic>> mapJson(List list) {
    List jsonList = List<Map<String, dynamic>>();
    if (list == null || list.isEmpty) return jsonList;
    list.map((item) => jsonList.add(item.toJson())).toList();
    jsonList.toList();
    return jsonList;
  }

  dummyJournalData() {
    JournalEntry journalEntry1 = new JournalEntry(
        userId: this.userId,
        journalId: this.id,
        type: 'record',
        recordEntry: 1,
        reportUnitsIndex: this.reportUnitsIndex,
        createdAt: DateTime.now());

    JournalEntry journalEntry2 = new JournalEntry(
        userId: this.userId,
        journalId: this.id,
        type: 'record',
        recordEntry: 4,
        reportUnitsIndex: this.reportUnitsIndex,
        createdAt: DateTime.now());

    JournalEntry journalEntry3 = new JournalEntry(
        userId: this.userId,
        journalId: this.id,
        type: 'record',
        recordEntry: 69,
        reportUnitsIndex: this.reportUnitsIndex,
        createdAt: DateTime.now());

    this.journalEntries = List()
      ..add(journalEntry1)
      ..add(journalEntry2)
      ..add(journalEntry3);
  }
}
