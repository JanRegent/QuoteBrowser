String sheetRowsCreateTable() {
  return '''
    CREATE TABLE IF NOT EXISTS sheetrows(
            id SERIAL PRIMARY KEY,
            rowkey TEXT ,
            sheetname TEXT,
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
    'rowkey,sheetname,quote,author,book,parPage,tags,yellowparts,stars,favorite,dateinsert,sourceUrl,fileurl,docUrl,original,vydal,folderUrl,title';

String filtersCreateTable() {
  return '''
    CREATE TABLE IF NOT EXISTS wfilters(
            id SERIAL PRIMARY KEY,
            filtertype TEXT ,
            w1 TEXT,
            w2 TEXT,
            w3 TEXT,
            w4 TEXT,
            w5 TEXT,
            author  TEXT,
            book TEXT,
            stars real,
            starsany TEXT,
            favorite TEXT            
    )
    ''';
}
