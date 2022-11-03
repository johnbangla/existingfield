import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:buro_employee/repository/models/login_user.dart';

import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginUser?>{


  BuroRepository buroRepository;

  LoginCubit({required this.buroRepository}) : super(null);




  Future<LoginUser> authenticate(String username, String password) async {

    print("Authenticate Called");

    var response = await this.buroRepository.authenticate(username, password);

    emit(response);

    return  response;
  }









}