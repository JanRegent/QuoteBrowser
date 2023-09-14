String catsMock = '''
Přehled úkolu/Co je Quest
Přehled úkolu/Jeho volba
Přehled úkolu/Nezávislá cesta
Přehled úkolu/organizované skupiny
Přehled úkolu/Seberozvoj
Přehled úkolu/Student-Učitel
Přehled příslušných postupů/Mravenčí dlouhá cesta
Přehled příslušných postupů/Míra pokroku
Přehled příslušných postupů/Nejistoty pokroku
Přehled příslušných postupů/Cvičte mentální disciplínu
Přehled příslušných postupů/Uveďte do rovnováhy psychiku
Přehled příslušných postupů/Sebereflexe a jednání
Přehled příslušných postupů/Disciplína Touhy
Přehled příslušných postupů/Hledání a společenská odpovědnost
Přehled příslušných postupů/Závěr
Relax a ústup/Udělejte si občasné pauzy
Relax a ústup/Vytáhněte z napětí a tlaku
Relax a ústup/Uvolněte tělo dech mysl
Relax a ústup/Retreat Centers
Relax a ústup/Samota
Relax a ústup/Ocenění přírody
Relax a ústup/Kontemplace západu slunce
Základní meditace/Přípravný
Základní meditace/Místo a stav
Základní meditace/Základy
Základní meditace/Meditativní myšlení
Základní meditace/Vizualizace symboly
Základní meditace/Mantram Afirmace
Základní meditace/Všímavost duševní klid
Tělo/Tělo
Tělo/Dieta
Tělo/Půst
Tělo/Cvičení
Tělo/Dechová cvičení
Tělo/Sex
Kundalini/
The Body/Prayer
Emoce a etika/Povznášející charakter
Emoce a etika/Převychovávejte pocity
Emoce a etika/Disciplína Emoce
Emoce a etika/Očistěte vášně
Emoce a etika/Duchovní zušlechťování
Emoce a etika/Různé etické otázky
Intelekt/Místo intelektu
Intelekt/Služba intelektu
Intelekt/Rozvoj intelektu
Intelekt/Abstraktní myšlenka
Intelekt/Věda
Intelekt/Metafyzika pravdy
Intelekt/Intelekt realita a nadjá
Ego/Co jsem?
Ego/Myslel jsem
Ego/Psychika
Ego/Odpoutání se od ega (část I)
Od narození ke znovuzrození/Smrt umírání a nesmrtelnost
Od narození ke znovuzrození/Znovuzrození a reinkarnace
Od narození ke znovuzrození/Zákony a vzorce zkušenosti
Od narození ke znovuzrození/Svobodná vůle odpovědnost a světová myšlenka
Uzdravení Já/Přírodní zákony
Uzdravení Já/Univerzální životní síla
Uzdravení Já/Původ nemoci
Uzdravení Já/léčitelé těla a mysli
Uzdravení Já/Léčivá síla Nadjá
Negativa/Jejich povaha
Negativa/Jejich kořeny v egu
Negativa/Jejich přítomnost ve světě
Negativa/V myšlenkách pocitech násilných vášních
Negativa/Jejich viditelné a neviditelné poškození
Úvahy/Filosofie a současná kultura
Úvahy/Setkání s osudem
Úvahy/úvahy o pravdě
Úvahy/Literární dílo
Úvahy/Profánní a hluboký
Lidská zkušenost/Situace
Lidská zkušenost/Mládí a věk
Lidská zkušenost/Světová krize
Umění v kultuře/Poděkování
Umění v kultuře/Kreativita génius
Umění v kultuře/Umělecká zkušenost a mystika
Umění v kultuře/Úvahy o specifických uměních
Orient/Setkání Východu a Západu
Orient/Indie část
Citlivé osoby/Mystický život v moderním světě
Citlivé osoby/fáze mystického vývoje
Citlivé osoby/Filosofie mystika a okultismus
Citlivé osoby/Ti kteří hledají
Citlivé osoby/Cesta individuality
Citlivé osoby/Inspirace a zmatek
Citlivé osoby/Citlivá mysl
Citlivé osoby/Osvětlení
Náboženské nutkání/Původ účel náboženství
Náboženské nutkání/Organizace obsah náboženství
Náboženské nutkání/Náboženství jako příprava
Náboženské nutkání/Problémy organizovaného náboženstv
Náboženské nutkání/komentářů ke konkrétním náboženstvím
Náboženské nutkání/Filosofie a náboženství
Náboženské nutkání/Za náboženstvím jak ho známe
Ctihodný život/Oddanost
Ctihodný život/Modlitba
Ctihodný život/Pokora
Ctihodný život/Vzdejte se
Ctihodný život/Milost
Vláda Relativity/Kosmos změny
Vláda Relativity/Dvojité stanovisko
Vláda Relativity/Stavy vědomí
Vláda Relativity/Čas prostor kauzalita
Co je to filozofie?/Směrem k definování filozofie
Mentalismus/Sensed World
Mentalismus/Svět jako mentáln
Mentalismus/Individuální a světová mysl
Mentalismus/Výzva mentalismu
Mentalismus/Klíč k duchovnímu světu
Inspirace a Nadjá/Intuice na začátku
Inspirace a Nadjá/Inspirace
Inspirace a Nadjá/Přítomnost Nadjá
Inspirace a Nadjá/Úvod do mystických pohledů
Inspirace a Nadjá/Příprava na letmé pohledy
Inspirace a Nadjá/Zažijte letmý pohled
Inspirace a Nadjá/After the Glimpse
Inspirace a Nadjá/Záblesky a trvalé osvětlení
Pokročilá kontemplace/Zadání krátké cesty
Pokročilá kontemplace/Úskalí a omezení
Pokročilá kontemplace/Temná noc duše
Pokročilá kontemplace/Přechod na krátkou cestu
Pokročilá kontemplace/Vyvažování cest
Pokročilá kontemplace/Pokročilá meditace
Pokročilá kontemplace/Kontemplativní ticho
Pokročilá kontemplace/Prázdnota jako kontemplativní zkušenost
Mír ve vás/Hledání štěstí
Mír ve vás/Buďte v klidu
Mír ve vás/Procvičte si oddělení
Mír ve vás/Hledejte hlubší klid
Světová mysl v individuální mysli/Jejich setkání a výměna
Světová mysl v individuální mysli/Osvícení které zůstane
Světová mysl v individuální mysli/Mudrc  část
Světová mysl v individuální mysli/Mudrc  část
Světová mysl v individuální mysli/Služba mudrců
Světová myšlenka/Božský řád vesmíru
Světová myšlenka/Změna jako univerzální aktivita
Světová myšlenka/Polarity komplementáře duality vesmíru
Světová myšlenka/Pravá idea člověka
Světová mysl/Co je Bůh?
Světová mysl/Povaha světové mysli
Světová mysl/Světová mysl a Stvoření'
Sám/Absolutní mysl
Sám/Náš vztah k Absolutnu
''';

int catsLen() {
  return catsMock.split('\n').length;
}

List<List<String>> getCatsL1L2() {
  List<List<String>> l1l2list = [];

  List<String> catsMocks = catsMock.split('\n');
  for (String row in catsMocks) {
    List<String> l1l2row = row.split('/');
    try {
      l1l2list.add([l1l2row[0], l1l2row[1]]);
    } catch (_) {}
  }
  return l1l2list;
}

List<String> catsL1() {
  List<String> l1 = [];

  List<String> catsMocks = catsMock.split('\n');
  for (String row in catsMocks) {
    List<String> l1l2 = row.split('/');
    try {
      l1.add(l1l2[0]);
    } catch (_) {}
  }
  return l1;
}

List<String> catsL2(String l1) {
  List<String> l2 = [];

  List<String> catsMocks = catsMock.split('\n');
  for (String row in catsMocks) {
    List<String> l1l2 = row.split('/');
    if (l1 != l1l2[0]) continue;
    try {
      l2.add(l1l2[1]);
    } catch (_) {}
  }
  return l2;
}
