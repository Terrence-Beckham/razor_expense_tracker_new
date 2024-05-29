part of 'home_cubit.dart';

enum HomeTab { expenses, stats }

final class HomeState extends Equatable {
  const HomeState({
    this.tab = HomeTab.expenses,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}