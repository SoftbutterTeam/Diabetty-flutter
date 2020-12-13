import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diabetty/models/teams/relationship.dart';

class TeamRepository {
  TeamRepository();
  final Firestore _db = Firestore.instance;

  Future<bool> createContract(Contract contract) async {
    Map<String, dynamic> contractData = contract.toJson();

    if (contract.supporteeId == null || contract.supporterId == null) {
      return false;
    }

    DateTime timeNow = DateTime.now();
    contractData['createdAt'] = timeNow;
    contractData['updatedAt'] = timeNow;

    DocumentReference dr = await _db.collection('contracts').document();

    await dr.setData(contractData).catchError((e) {
      return false;
    });
    await createRelationship(
        dr.documentID, contract.supporterId, contract.supporteeId);
    return true;
  }

  //*accidently wrote the same thing twice, how banter
/*
  Future<bool> updateContract(Contract contract) async {
    Map<String, dynamic> contractData = contract.toJson();

    if (contract.id == null ||
        contract.supporteeId == null ||
        contract.supporterId == null) {
      return false;
    }

    DateTime timeNow = DateTime.now();
    contractData['updatedAt'] = timeNow;

    DocumentReference dr =
        await _db.collection('contracts').document(contract.id);

    await dr.setData(contractData).catchError((e) {
      return false;
    });
    await updateRelationship(
        dr.documentID, contract.supporterId, contract.supporteeId);
    return true;
  }
*/
  Future<bool> createRelationship(String contractid, user1, user2) async {
    Map<String, dynamic> contractIdMap = {
      'contractId': contractid,
      'supporter': user1,
      'supportee': user2,
      'createdAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    };

    await _db
        .collection('users')
        .document(user1)
        .collection('relations')
        .document(user2)
        .setData(contractIdMap)
        .catchError((e) {
      return false;
    });
    await _db
        .collection('users')
        .document(user2)
        .collection('relations')
        .document(user1)
        .setData(contractIdMap)
        .catchError((e) {
      return false;
    });
    return false;
  }

  Future<bool> updateRelationship(String contractid, user1, user2) async {
    Map<String, dynamic> contractIdMap = {
      'updatedAt': DateTime.now(),
    };

    await _db
        .collection('users')
        .document(user1)
        .collection('relations')
        .document(user2)
        .updateData(contractIdMap)
        .catchError((e) {
      return false;
    });
    await _db
        .collection('users')
        .document(user2)
        .collection('relations')
        .document(user1)
        .updateData(contractIdMap)
        .catchError((e) {
      return false;
    });
    return false;
  }

  Future<DataResult<List<Map<String, dynamic>>>> getAllContracts(String userId,
      {bool local = false}) async {
    Source source = local ? Source.cache : Source.server;
    try {
      var relations = await _db
          .collection("users")
          .document(userId)
          .collection('relations')
          .getDocuments(source: source);
      var contracts = await getContractsByRelations(relations);

      var contractsJson = contracts.map((e) {
        Map<String, dynamic> json = Map<String, dynamic>.from(e.data)
          ..['id'] = e.documentID;
        return json;
      }).toList();

      return DataResult<List<Map<String, dynamic>>>(data: contractsJson);
    } catch (exception, stackTrace) {
      return DataResult(exception: exception, stackTrace: stackTrace);
    }
  }

  Future<List<DocumentSnapshot>> getContractsByRelations(
      QuerySnapshot relations) async {
    List<DocumentSnapshot> contracts = List();
    for (var item in relations.documents) {
      DocumentSnapshot contract = await _db
          .collection('contracts')
          .document(item.data['contractId'])
          .get();
      contracts.add(contract);
    }

    return contracts;
  }

  Stream<QuerySnapshot> onStateChanged(String uid) {
    return _db
        .collection('users')
        .document(uid)
        .collection('relations')
        .snapshots();
  }

  Future<void> updateContract(Contract contract) async {
    // reminder.
    Map<String, dynamic> contractData = Map();
    if (contract.id == null) return null;

    contractData = contract.toJson();
    contractData['updatedAt'] = DateTime.now();
    await _db
        .collection('contracts')
        .document(contract.id)
        .updateData(contractData)
        .catchError((e) {
      print('error');
      print(e);
    });

    await updateRelation(contract.supporterId, contract.supporteeId);
    await updateRelation(contract.supporteeId, contract.supporterId);

    return;
  }

  Future<void> deleteContract(Contract contract) async {
    // reminder.
    await _db
        .collection('contracts')
        .document(contract.id)
        .delete()
        .catchError((e) {
      print('error');
      print(e);
    });

    await deleteRelation(contract.supporterId, contract.supporteeId);
    await deleteRelation(contract.supporteeId, contract.supporterId);

    return;
  }

  Future<void> deleteRelation(String relationId, String uid) async {
    // reminder.
    await _db
        .collection('users')
        .document(uid)
        .collection('relations')
        .document(relationId)
        .delete()
        .catchError((e) {
      print('error');
      print(e);
    });

    return;
  }

  Future<void> updateRelation(String relationId, String uid) async {
    Map<String, dynamic> contractData = Map();
    contractData['updatedAt'] = DateTime.now();
    // reminder.
    await _db
        .collection('users')
        .document(uid)
        .collection('relations')
        .document(relationId)
        .updateData(contractData)
        .catchError((e) {
      print('error');
      print(e);
    });
  }
}

// Update Relationships on changes to detect change

class DataResult<T> {
  final T data;
  final Exception exception;
  final StackTrace stackTrace;

  DataResult({this.data, this.exception, this.stackTrace});

  bool get isSuccess => exception == null;
}
