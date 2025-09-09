part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object?> get props => [];
}

class FilterInitial extends FilterState {}

class FilterUpdated extends FilterState {
  final Map<String, dynamic> filterOptions;

  const FilterUpdated(this.filterOptions);

  @override
  List<Object?> get props => [filterOptions];
}

class FilterCleared extends FilterState {}
