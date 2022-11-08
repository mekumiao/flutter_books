import 'package:configuration_repository/src/local_storage.dart';

class MemoryStorage extends LocalStorage {
  MemoryStorage([LocalStorageModel model = const LocalStorageModel()])
      : _model = model;

  LocalStorageModel _model;

  @override
  LocalStorageModel get model => _model;

  @override
  set model(LocalStorageModel data) => _model = data;
}
