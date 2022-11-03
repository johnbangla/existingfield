import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateRole extends StatefulWidget {
  static const routeName = '/createRole';

  //const AcceptReqList({Key? key}) : super(key: key);
  static route() => MaterialPageRoute(builder: (_) => CreateRole());

  @override
  _CreateRoleState createState() => _CreateRoleState();
}

class _CreateRoleState extends State<CreateRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Role Creation'),
        ),
        body: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Role Name',
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Data View',
                      suffixIcon: Icon(Icons.arrow_drop_down_sharp)),
                  enabled: false,
                )),
            SizedBox(
              height: 30,
            ),
            Text(
              'Permission Module',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            )


          ],
        ));
  }
}
