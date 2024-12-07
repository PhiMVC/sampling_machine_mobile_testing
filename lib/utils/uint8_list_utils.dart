class Uint8ListUtils {
  static bool compare(String bytes1, String bytes2) {
    List<String> listByte1 = bytes1.split(" ").toList();
    List<String> listByte2 = bytes2.split(" ").toList();

    int i;
    for (i = 0; i < listByte1.length; i++) {
      if (int.parse(listByte1[i], radix: 16) !=
          int.parse(listByte2[i], radix: 16)) {
        return false;
      }
    }
    return true;
  }
}
