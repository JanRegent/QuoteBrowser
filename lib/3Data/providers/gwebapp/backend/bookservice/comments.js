

function getCommentsFromDocument(fileId) {

    var options = {
      'maxResults': 99  ,
      'fields': 'comments'
    };
  
    log(fileId);
  
    //var commentsList = Drive.Comments.list(fileId, options); //nekdy GoogleJsonResponseException: API call to drive.comments.list failed with error: Invalid field selection comments
    
    var commentsList = Drive.Comments.list(fileId);
    if (commentsList.items == 0) return undefined;
  
    logs(commentsList)
    var comments = commentsList['comments']
    //log(JSON.stringify(comments))
    
    try {
      if (comments.length == 0) return undefined;
    }catch(e) {
      log(e)
      return undefined;
    }
  
  
    //----------------------------------------------------------------getTagsTg, yellowParts
    var tagComment = []
    var tagsTgStr = '';
    for (var i = 0; i < comments.length; i++) {
      var commentTags = comments[i]['content'];     
      tagsTgStr = '#' + commentTags.replaceAll('tg ','').trim();
      tagsTgStr = tagsTgStr.replaceAll('\n','#')
      tagsTgStr = tagsTgStr.replaceAll(',','#')
     var yellowDecoded = toCestin(comments[i]['quotedFileContent']['value'])
       ''
      tagComment.push({"tags": tagsTgStr, "yellowPart": yellowDecoded});
  
    }
    //log(JSON.stringify(tagComment))
    return tagComment
  
  }
  
  function getCommentsFromDocument___test() {
    getCommentsFromDocument('17XwQ-0whgCL96fq4nHoHtr2mqJc-th9Gz0iPj8-zIo4')
  }
  