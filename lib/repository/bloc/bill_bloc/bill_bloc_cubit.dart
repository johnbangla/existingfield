import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
part 'bill_bloc_state.dart';

enum CounterEvent { increment, decrement }

class BillBlocCubit extends Bloc<CounterEvent,BillBlocState> {

  BuroRepository buroRepository ;

  BillBlocCubit({required this.buroRepository}) : super(BillBlocState(counterValue: false));


  //BillBlocCubit() : super(BillBlocInitialState());


  @override
  Stream<BillBlocState> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield BillBlocState(counterValue: true);
        break;
      case CounterEvent.decrement:
        yield BillBlocState(counterValue: false);
        break;
    }
  }
}
