abstract class CacheManager<T>{
  Future<T> get(String key);
  Future<bool> put(String key, T value);
  Future<bool> putString(String key, String value);
  Future<bool> delete(String key);
  Future<bool> contains(String key);
}