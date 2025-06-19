import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app_flutter/features/electronics/data/products_repo.dart';
import 'package:my_app_flutter/features/electronics/model/products_model.dart';
part 'electronics_event.dart';
part 'electronics_state.dart';

class ElectronicsBloc extends Bloc<ElectronicsEvent, ElectronicsState> {
  final ProductsRepo _productsRepo = ProductsRepo();
  ElectronicsBloc() : super(ElectronicsInitialState()) {
    on<ElectronicsEvent>((event, emit) async {
      List<ProductsModel> electronicsData =
          await _productsRepo.getElectronics();
      emit(ElectronicsLoadedState(electronicsData: electronicsData));
    });

    add(ElectronicsInitialEvent());
  }
}

class ElectronicsBlocEvent {
}