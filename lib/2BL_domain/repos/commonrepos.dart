String createTable() {
  return '''
    CREATE TABLE IF NOT EXISTS sheetrows(
            id SERIAL PRIMARY KEY,
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

String colsSql =
    'rownokey,sheetname,rowno,quote,author,book,parpage,tags,yellowparts,stars,favorite,dateinsert,sourceurl,fileurl,docurl,original,vydal,folderurl,title';
