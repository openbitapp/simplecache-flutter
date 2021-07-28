import 'package:functional_dart/functional_dart.dart';

/// Interfaccia del servizio di cache da specificare nel service locator.\
/// Usata nei ViewModels e nel file service_locator.dart
abstract class CacheService {
  void add<T>({required T object, required String cacheId, required Duration expireAfter});
  Option<T> getBack<T>({required String cacheId});
  void clear();
}
