function book2kaps() {

    var folderId = '1KNPDQ1jdUauaRQFYhcoaB__YAXxi_GeO'
    var folderUrl = 'https://drive.google.com/drive/folders/' + folderId;
  
   var sheet = SpreadsheetApp.openByUrl('https://docs.google.com/spreadsheets/d/1ZbO7cork3WxMPCVsVGTRZ1GSjxk-LBbaQCEFK6igBLE/edit#gid=705082603').getSheetByName('JÁ SKUTEČNOST O SOBĚ');
    sheet.clear()
    sheet.appendRow(['quote', 'author', 'book', 'parPage', 'tags', 'yellowParts', 'stars', 'favorite', 'categories', 'dateinsert', 'vydal', 'folder', 'sourceUrl', 'title', 'docUrl']);
  
    var doc =DocumentApp.openByUrl('https://docs.google.com/document/d/1SxWtf8eFZbxSj6rDvo60S0RF1ENeDA4XjBUWRad4O_g/edit');
    var body = doc.getBody().getText();
  
  
    for (var i = 1; i < 57; i = i + 1) {
      //var start = lines[i].startsWith(i+'. ')
      var startStr = '\n' + i.toString() +'. '
      var startStr2 = '\n' + (i+1).toString() +'. '
      log('-------------------------' + i)
      var kap = betwenStrings(body, startStr,startStr2)
      var title = startStr +  kap.split('\n')[0]
      log(title)
      var sourceUrl = 'https://www.advaita.cz/wcd/e-knihy/nisargadatta/312953c44_nis_jaskutecnost.pdf'
  
      var parPage = i;
      if (i < 10 ) parPage = '0' + parPage
  
   
      var docUrl = docCreate(folderId, title, sourceUrl, kap)
      sheet.appendRow(['__toRead__', 'Nisargadatta Mahárádž', 'JÁ SKUTEČNOST O SOBĚ', parPage, , '', '', '', '', '', '', folderUrl, sourceUrl, title, docUrl]);
  
    }
  
  }
  
  
  
  var kaps = [
  '1. Pýcha z úspěchů',
  '2. Vědomí, naše jediné „jmění',
  '3. Navzdory smrti',
  '4. Projevené a Neprojevené je Jedno a Totéž',
  '6. Omezení prostorem a časem',
  '7. Jak džnánin vidí svět',
  '8. Důkaz pravdy',
  '9. Ty jsi Ráma, já jsem Ráma',
  '12. Projevený svět je snem',
  '13. Láska a Bůh',
  '14. Z jakého hlediska číst Bhagavadgítu?',
  '15. Slepý mladík s pravým viděním',
  '16. Přišel se posmívat',
  '17. Absolutno a projev',
  '18. Pochopme základní fakta',
  '19. Poznání sebe sama a životní problémy',
  '22. Seberealizace nemůže být vynucena',
  '23. Dítě neplodné ženy',
  '24. Přezkoumání základů vlastní přirozenosti',
  '25. Co ve skutečnosti jsme?',
  '26. Život je fraška',
  '27. Chybné ztotožňení je ,omezením‘',
  '28. Jsi Věčný',
  '29. Nic takového jako ,Osvícení‘ tu není',
  '32. Osobní zkušenost',
  '33. Není žádný Vnímající, je pouze Vnímání',
  '34. Neposkvrněná identita',
  '35. Naprostá nepřítomnost konatele',
  '36. ,Nikdo‘ se nerodí; ,nikdo‘ neumírá',
  '37. Spekulativní myšlení',
  '38. Čiré bytí je Bůh',
  '39. Jste Vědomá Přítomnost',
  '42. Intelekt se může stát drogou',
  '43. Pravda znamená vidět neskutečné jako neskutečné',
  '44. Fušování do meditace',
  '46. Popření existence entity',
  '47. Hledající je tím, co je hledáno',
  '48. Podstata hlubokého spánku',
  '49. Rozpuštění konceptu „ty“',
  '51. Kdo trpí?',
  '52. Pokrok v duchovním hledání',
  '53. Trpět zkušeností',
  '54. Slova a jejich naplnění',
  '56. Poslední dny a poslední učení',
  '57. Poslední okamžiky: Mahásamádhi',
  'Dodatek I: Jádro učení',
  'DODATEK II: Poznámka o vědomí',
  'DODATEK III: Bhakti, džnána a jedinec',
  'DODATEK IV: Celá pravda',
  'DODATEK V: Slovník'
  
  
  ]