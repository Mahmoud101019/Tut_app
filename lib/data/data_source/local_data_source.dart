import 'package:tut_app/data/network/error_handler.dart';
import 'package:tut_app/data/response/responses.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60 * 1000;

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();

  Future<void> saveHomeToCache(HomeResponse homeResponse);

  void clearCache();

  void removeFromCache(String key);
}

///////////////////////////////////////////////////////////////////////////////

class LocalDataSourceImpl implements LocalDataSource {
  //run time cache

  Map<String, ChchedItem> cacheMap = Map();
  @override
  Future<HomeResponse> getHomeData() async {
    ChchedItem? chchedItem = cacheMap[CACHE_HOME_KEY];

    if (chchedItem != null && chchedItem.isValid(CACHE_HOME_INTERVAL)) {
      return chchedItem.data;
    } else {
      throw ErrorHandler.handle(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = ChchedItem(data: homeResponse);
  }

  @override
  void clearCache() {
    cacheMap.clear();
  }

  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

///////////////////////////////////////////////////////////////////////////////

class ChchedItem {
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  ChchedItem({
    required this.data,
  });
}

///////////////////////////////////////////////////////////////////////////////

extension ChchedItemExtension on ChchedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    // expirationTimeInMillis -> 60 sec
    // currentTimeInMillis -> 1:00:00
    // cacheTime -> 12:59:30
    // valid -> till 1:00:30
    return isValid;
  }
}
