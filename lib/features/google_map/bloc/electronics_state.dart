part of 'electronics_bloc.dart';

abstract class ElectronicsState {}

final class ElectronicsInitialState extends ElectronicsState {}

final class ElectronicsLoadedState extends ElectronicsState {
  final List<ProductsModel> electronicsData;
  ElectronicsLoadedState({required this.electronicsData});
}