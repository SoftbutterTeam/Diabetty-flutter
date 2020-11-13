import 'package:diabetty/models/journal/journal_entry.moel.dart';

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
}
