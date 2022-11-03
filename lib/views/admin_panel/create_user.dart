
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CreateUser extends StatefulWidget {

  static const routeName = '/createUser';

  //const CreateUser({Key? key}) : super(key: key);

  static route() => MaterialPageRoute(builder: (_) => CreateUser());


  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create User'),),
        body: Container(child:Text('Create User')));
  }
}
