import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class AppCacheManager {
  static CacheManager get manager => CacheManager(Config(
        'sampling_cache_key',
        stalePeriod: const Duration(days: 7),
        repo: JsonCacheInfoRepository(),
        maxNrOfCacheObjects: 30,
        fileService: HttpFileService(),
      ));

  static Future<FileInfo?> getFileInfo({required String key}) async {
    FileInfo? fileInfo = await AppCacheManager.manager.getFileFromCache(key);
    fileInfo ??= await AppCacheManager.manager.downloadFile(
      key,
      key: key,
    );
    return fileInfo;
  }
}
