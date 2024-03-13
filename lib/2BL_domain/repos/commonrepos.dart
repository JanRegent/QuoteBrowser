String createTable() {
  return '''
    CREATE TABLE IF NOT EXISTS sheetrows(
            id serial  PRIMARY KEY, 
            rownokey TEXT,
            sheetname TEXT,
            rowno TEXT,
            quote TEXT,
            author TEXT,
            book TEXT,
            parpage TEXT,
            tags TEXT,
            yellowparts TEXT,
            stars TEXT,
            favorite TEXT,
            dateinsert TEXT,
            sourceurl TEXT,
            fileurl TEXT,
            docurl TEXT,
            original TEXT,
            vydal TEXT,
            folderurl TEXT,
            title TEXT
    )
    ''';
}
