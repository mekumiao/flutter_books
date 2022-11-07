extension ApiExtension on int? {
  int toNo(int limit) {
    assert(limit > 0, 'limit必须大于0');
    final startIndex = this;
    if (startIndex == null || startIndex <= 0) return 0;
    return (startIndex.toDouble() / limit).ceil() + 1;
  }
}
