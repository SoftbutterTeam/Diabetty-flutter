import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/teams/relationship.dart';
import 'package:diabetty/repositories/team.repository.dart';
import 'package:diabetty/services/authentication/auth_service/user.service.dart';

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
      print('here1');
      final contracts =
          (await _teamRepository.getAllContracts(uid, local: local)).data;
      if (contracts == null || contracts.isEmpty) {
        return List();
      }
      var contractList = contracts.map<Contract>((json) {
        Contract contract = Contract();
        contract.id = json['id'];

        return contract..loadFromJson(json);
      }).toList();
      print('here1');
      for (var contract in contractList) {
        if (contract.supporteeId == uid)
          contract.supporter =
              await UserService().fetchUser(contract.supporterId);
        else
          contract.supportee =
              await UserService().fetchUser(contract.supporteeId);
        print('contrrr');
        print(contract.supportee);
      }
      print('here2');

      return contractList;
    } catch (e) {
      print('here');

      print(e);
      return List();
    }
  }

  Stream<QuerySnapshot> relationsStream(String uid) {
    return _teamRepository.onStateChanged(uid);
  }

  Future<void> updateContract(Contract contract) async {
    try {
      await _teamRepository.updateContract(contract);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteContract(Contract contract) async {
    try {
      await _teamRepository.deleteContract(contract);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
