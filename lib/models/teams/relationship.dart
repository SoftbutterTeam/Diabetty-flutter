class Contract {
  String id;
  String supporterId;
  String supporteeId;
  String status;
  Permissions permissions;
  DateTime acceptedAt;

  Contract({
    this.id,
    this.supporterId,
    this.supporteeId,
    this.status,
    this.permissions,
  }) {
    permissions ??= new Permissions();
  }

  loadFromJson(Map<String, dynamic> json) {
    this.id ??= json['id'];
    this.supporterId = json['supporterId'];
    this.supporteeId = json['supporteeId'];
    this.status = json['status'];
    this.permissions = Permissions.fromJson(json['permissions']);
    this.acceptedAt =
        json['acceptedAt'] == null ? null : DateTime.parse(json['accepted']);
  }

  Map<String, dynamic> toJson() => {
        'supporterId': this.supporterId,
        'supporteeId': this.supporteeId,
        'status': this.status,
        'permissions': this.permissions.toJson(),
        'acceptedAt': this.acceptedAt.toString(),
      };
}

class Permissions {
  bool readTherapy = false;
  bool readDayPlan = true;
  bool readHistroy = false;
  bool readDiary = false;

  Permissions(
      {this.readTherapy = false,
      this.readDayPlan = true,
      this.readHistroy = false,
      this.readDiary = false});

  Permissions.fromJson(dynamic json) {
    loadFromJson(json);
  }

  loadFromJson(dynamic jsonMap) {
    Map<String, dynamic> json = Map<String, dynamic>.from(jsonMap);
    this.readTherapy = json['readTherapy'];
    this.readDayPlan = json['readDayPlan'];
    this.readHistroy = json['readHistory'];
    this.readDiary = json['readDiary'];
  }

  Map<String, dynamic> toJson() => {
        'readTherapy': this.readTherapy,
        'readDayPlan': this.readDayPlan,
        'readHistory': this.readHistroy,
        'readDiary': this.readDiary,
      };
}
