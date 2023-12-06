import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Add_data {
  String name;
  String explain;
  String amount;
  String IN;
  DateTime datetime;

  Add_data(this.IN, this.amount, this.datetime, this.explain, this.name);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'explain': explain,
      'amount': amount,
      'IN': IN,
      'datetime': datetime,
    };
  }

  static Add_data fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Add_data(
      data['IN'],
      data['amount'],
      (data['datetime'] as Timestamp).toDate(),
      data['explain'],
      data['name'],
    );
  }

  Future<void> addToFirestore(String userId) async {
    await FirebaseFirestore.instance
        .collection('history')
        .doc()
        .set(toMap());
  }

  Future<void> updateInFirestore(String documentId) async {
    await FirebaseFirestore.instance
        .collection('history')
        .doc(documentId)
        .update(toMap());
  }

  Future<void> deleteFromFirestore(String documentId) async {
    await FirebaseFirestore.instance
        .collection('history')
        .doc(documentId)
        .delete();
  }
}

Future<List<Add_data>> getDataFromFirestore() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('history')
            .where('userId', isEqualTo: user.uid)
            .get();

    List<Add_data> history2 = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
        in querySnapshot.docs) {
      history2.add(Add_data.fromSnapshot(documentSnapshot));
    }
    return history2;
  } else {
    return [];
  }
}

Future<int> total() async {
  List<Add_data> history2 = await getDataFromFirestore();
  List<int> a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  int totals = a.reduce((value, element) => value + element);
  return totals;
}

Future<int> income(List<Add_data> history) async {
  List<Add_data> history2 = await getDataFromFirestore();
  List<int> a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? int.parse(history2[i].amount) : 0);
  }
  int totals = a.reduce((value, element) => value + element);
  return totals;
}

Future<int> expenses(List<Add_data> history) async {
  List<Add_data> history2 = await getDataFromFirestore();
  List<int> a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income' ? 0 : int.parse(history2[i].amount) * -1);
  }
  int totals = a.reduce((value, element) => value + element);
  return totals;
}

Future<List<Add_data>> today() async {
  List<Add_data> a = [];
  List<Add_data> history2 = await getDataFromFirestore();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.day == date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

Future<List<Add_data>> week() async {
  List<Add_data> a = [];
  List<Add_data> history2 = await getDataFromFirestore();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (date.day - 7 <= history2[i].datetime.day &&
        history2[i].datetime.day <= date.day) {
      a.add(history2[i]);
    }
  }
  return a;
}

Future<List<Add_data>> month() async {
  List<Add_data> a = [];
  List<Add_data> history2 = await getDataFromFirestore();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.month == date.month) {
      a.add(history2[i]);
    }
  }
  return a;
}

Future<List<Add_data>> year() async {
  List<Add_data> a = [];
  List<Add_data> history2 = await getDataFromFirestore();
  DateTime date = DateTime.now();
  for (var i = 0; i < history2.length; i++) {
    if (history2[i].datetime.year == date.year) {
      a.add(history2[i]);
    }
  }
  return a;
}

int total_chart(List<Add_data> history2) {
  List<int> a = [0, 0];
  for (var i = 0; i < history2.length; i++) {
    a.add(history2[i].IN == 'Income'
        ? int.parse(history2[i].amount)
        : int.parse(history2[i].amount) * -1);
  }
  int totals = a.reduce((value, element) => value + element);
  return totals;
}

List<int> time(List<Add_data> history2, bool hour) {
  List<Add_data> a = [];
  List<int> total = [];
  int counter = 0;
  for (var c = 0; c < history2.length; c++) {
    for (var i = c; i < history2.length; i++) {
      if (hour) {
        if (history2[i].datetime.hour == history2[c].datetime.hour) {
          a.add(history2[i]);
          counter = i;
        }
      } else {
        if (history2[i].datetime.day == history2[c].datetime.day) {
          a.add(history2[i]);
          counter = i;
        }
      }
    }
    total.add(total_chart(a));
    a.clear();
    c = counter;
  }
  return total;
}
