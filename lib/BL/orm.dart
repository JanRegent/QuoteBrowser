class Orm {
  Map<String, dynamic> row2map(List<String> cols, List<String> row,
      String sheetName, String rowNo, String fileId) {
    Map<String, dynamic> rowMap = {};
    rowMap["sheetName"] = sheetName;
    rowMap["rowNo"] = rowNo;
    if (rowNo == '1') {
      rowMap["colRow"] = cols;
      return rowMap;
    }

    for (var i = 0; i < cols.length; i++) {
      rowMap[cols[i]] = row[i];
    }
    rowMap["fileId"] = fileId;
    return rowMap;
  }
}
