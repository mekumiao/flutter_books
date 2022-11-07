library event_bus;

import 'package:diagnose_logger/diagnose_logger.dart';

abstract class Command {
  const Command(this.key);

  final String key;
}

abstract class CommandHandler<TCommand extends Command> {
  const CommandHandler(this.commandKey);

  final String commandKey;

  void handler(TCommand command);
}

class EventBus {
  EventBus._internal();

  static EventBus? _instance;

  static final EventBus instance = _instance ??= EventBus._internal();

  /// 存储事件回调方法
  final Map<String, CommandHandler> _events = {};

  /// 设置事件监听
  void addListener(CommandHandler handler) {
    _events[handler.commandKey] = handler;
  }

  /// 移除监听
  void removeListener(String commandKey) {
    _events.remove(commandKey);
  }

  /// 提交事件
  void commit<TCommand extends Command>(TCommand command) {
    try {
      _events[command.key]?.handler(command);
    } catch (e) {
      Log.logger.e(command.key, e);
    }
  }
}
