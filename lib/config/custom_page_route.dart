import 'package:flutter/cupertino.dart';

class CustomPageRoute extends PageRouteBuilder{

  final Widget child;
  final AxisDirection axisDirection;

  CustomPageRoute({required this.child,this.axisDirection = AxisDirection.right}) : super(transitionDuration: Duration(seconds: 3),
      reverseTransitionDuration: Duration(seconds: 1),
      pageBuilder: (context, animation, secondaryAnimation) => child);





  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {


    //return ScaleTransition(scale: animation,child: child,);

    /*return SlideTransition(position: Tween<Offset>(
      begin: Offset(-1,0),
      end: Offset.zero
    ).animate(animation),child: child,);*/

    return SlideTransition(position: Tween<Offset>(
        begin: Offset(0,1),
        end: Offset.zero
    ).animate(animation),child: child,);




  }





}
