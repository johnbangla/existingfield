import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/verify_otp.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:equatable/equatable.dart';

part 'forgot_pass_verification_state.dart';

class ForgotPassVerificationCubit extends Cubit<ForgotPassVerificationState> {



  BuroRepository buroRepository ;

  ForgotPassVerificationCubit({required this.buroRepository}) : super(ForgotPassVerificationInitialState());

  Future<VerifyOtp?> verifyOtpResetPass({required String mobileOtp,required String emailOtp }) async {
    emit(ForgotPassVerificationInitialState());


    try {
      emit(ForgotPassVerificationLoadingState());
      var response = await buroRepository.verifyOtpResetPass(mobileOtp, emailOtp);
      emit(ForgotPassVerificationLoadedState(response));
      return response;
    } catch (e) {
      emit(ForgotPassVerificationErrorState(e));
    }
  }



}
