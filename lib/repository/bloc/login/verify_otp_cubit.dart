import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:buro_employee/repository/bloc/login/verify_otp_state.dart';
import 'package:buro_employee/repository/models/verify_otp.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  final BuroRepository repository;

  VerifyOtpCubit(this.repository) : super(InitialState());

  Future<VerifyOtp?> verifyOtp({required String mobileOtp,required String emailOtp }) async {
    emit(InitialState());


    try {
      emit(LoadingState());
      var response = await repository.verifyOtp(mobileOtp, emailOtp);
      emit(LoadedState(response));
      return response;
    } catch (e) {
      emit(ErrorState());
    }
  }




}
