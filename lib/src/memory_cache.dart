import 'package:bitapp_functional_dart/bitapp_functional_dart.dart';
import 'cache_service.dart';

/// Implementa l'interfaccia CacheService e verrà specificata come istantza\
/// nel file service_locator.dart
class MemoryCache implements CacheService {
  final Map<String, CacheObject> _cache = <String, CacheObject>{};

  /// Aggiunge un oggetto alla cache. Se l'oggetto esiste già nella cache,\
  /// viene sostituito.
  @override
  void add<T>(
      {required T object,
      required String cacheId,
      required Duration expireAfter}) {
    _cache[cacheId] = CacheObject(obj: object, expireAfter: expireAfter);
  }

  /// Recupera un oggetto alla cache. Se l'oggetto non esiste oppure,\
  /// è scaduto, ritorna un None.
  @override
  Option<T> getBack<T>({required String cacheId}) {
    if (_cache.containsKey(cacheId)) {
      final obj = _cache[cacheId]!;
      if (obj.isExpired()) {
        _cache.remove(cacheId);
        return None();
      } else {
        return Some(obj.obj);
      }
    } else {
      return None();
    }
  }

  @override
  void clear() => _cache.clear();
}

/// Classe che rappresenta l'oggetto nella cache
class CacheObject<T> {
  final T obj;
  final Duration expireAfter;
  final DateTime timestamp = DateTime.now();

  CacheObject({required this.obj, required this.expireAfter});

  /// Testa se l'oggetto è scaduto
  bool isExpired() {
    final duration = DateTime.now().difference(timestamp);
    return duration > expireAfter;
  }
}
