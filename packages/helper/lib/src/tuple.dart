import 'package:equatable/equatable.dart';

class Tuple2<T1, T2> extends Equatable {
  const Tuple2({
    required this.item1,
    required this.item2,
  });

  final T1 item1;
  final T2 item2;

  @override
  List<Object?> get props => [item1, item2];
}

class Tuple3<T1, T2, T3> extends Equatable {
  const Tuple3({
    required this.item1,
    required this.item2,
    required this.item3,
  });

  final T1 item1;
  final T2 item2;
  final T3 item3;

  @override
  List<Object?> get props => [item1, item2, item3];
}

class Tuple4<T1, T2, T3, T4> extends Equatable {
  const Tuple4({
    required this.item1,
    required this.item2,
    required this.item3,
    required this.item4,
  });

  final T1 item1;
  final T2 item2;
  final T3 item3;
  final T4 item4;

  @override
  List<Object?> get props => [item1, item2, item3, item4];
}
