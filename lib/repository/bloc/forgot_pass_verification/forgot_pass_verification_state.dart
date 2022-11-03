part of 'forgot_pass_verification_cubit.dart';

abstract class ForgotPassVerificationState extends Equatable {
  const ForgotPassVerificationState();

  @override
    List<Object> get props => [];
}

class ForgotPassVerificationInitialState extends ForgotPassVerificationState { }

class ForgotPassVerificationLoadingState extends ForgotPassVerificationState { }

class ForgotPassVerificationLoadedState extends ForgotPassVerificationState {
    final  VerifyOtp data;

    ForgotPassVerificationLoadedState(this.data);

    @override
    List<Object> get props => [data];
}

class ForgotPassVerificationErrorState extends ForgotPassVerificationState {
    final error;

    ForgotPassVerificationErrorState(this.error);

    @override
    List<Object> get props => [error];
}
