library bloc_transformer;

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

/// 在处理当前event结束前，抛弃其余event。并且减速当前正在处理的event流
EventTransformer<E> throttleDroppable<E>({
  Duration? duration = const Duration(milliseconds: 300),
}) {
  return (events, mapper) {
    return droppable<E>().call(
      duration != null ? events.throttle(duration) : events,
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
