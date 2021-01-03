import 'package:data_demo2/models/account_model.dart';
import 'package:data_demo2/models/user_model.dart';
import 'package:hive/hive.dart';

class HiveDB {
  var box = Hive.box('task_two');
  // for user
  void storeUser (User user) async {
    box.put('user', user.toJson());
  }

  User loadUser() {
    return User.fromJson(box.get('user'));
  }

  void removeUser() async {
    box.delete('user');
  }

  // for account
  void storeAccount (Account account) async {
    box.put('account', account.toJson());
  }

  Account loadAccount () {
    return Account.fromJson(box.get('account'));
  }

  void removeAccount() async{
    removeUser();
    box.delete('account');
  }

  bool isEmpty() {
    return box.isEmpty;
  }
}