import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/teams/relationship.dart';
import 'package:diabetty/repositories/team.repository.dart';

class TeamService {
  TeamRepository _teamRepository = TeamRepository();

  Future<bool> createContract(myUid, suporteeUid) async {
    Contract newContract = new Contract(
        supporteeId: suporteeUid,
        supporterId: myUid,
        permissions: new Permissions(),
        status: 'pending');

    return await _teamRepository.createContract(newContract);
  }

  Future<List<Contract>> getContracts(String uid, {bool local = false}) async {
    try {
      final contracts =
          (await _teamRepository.getAllContracts(uid, local: local)).data;
      if (contracts == null) {
        return List();
      }
      return contracts.map<Contract>((json) {
        Contract contract = Contract();
        contract.id = json['id'];
        return contract..loadFromJson(json);
      }).toList();
    } catch (e) {
      print(e);
      return List();
    }
  }

  Stream<QuerySnapshot> relationsStream(String uid) {
    return _teamRepository.onStateChanged(uid);
  }
}
