library bloc_transformer;

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

/// 减速流并且确保流中同时只有一个event被处理
EventTransformer<E> throttleDroppable<E>({
  Duration duration = const Duration(milliseconds: 300),
}) {
  return (events, mapper) {
    return droppable<E>().call(
      events.throttle(duration),
      mapper,
    );
  };
}

EventTransformer<E> throttle<E>({
  Duration duration = const Duration(milliseconds: 300),
}) {
  return (events, mapper) {
    return events.throttle(duration);
  };
}
