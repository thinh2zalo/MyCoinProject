import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final String title;
  final int count;

  HomeState({
    HomeState state,
    String title,
    int count,
  })  : title = title ?? state?.title ?? '',
        count = count ?? state?.count ?? 0;

  @override
  List<Object> get props => [
        title,
        count,
      ];
}
