class JournalEntry {
  String userId;
  String id;
  String journalId;
  String type;
  double recordEntry;
  String notes;
  DateTime createdAt;

  JournalEntry(
      {this.userId,
      this.id,
      this.journalId,
      this.type,
      this.createdAt,
      this.recordEntry,
      this.notes});

  loadFromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.userId = json['userId'];
    this.journalId = json['journalId'];
    this.type = json['type'];
    this.createdAt = json['createdAt'];
    this.recordEntry = json['recordEntry'];
    this.notes = json['notes'];
  }

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'userId': this.userId,
        'journalId': this.journalId,
        'type': this.type,
        'recordEntry': this.recordEntry,
        'notes': this.notes,
        'createdAt': this.createdAt
      };
}
