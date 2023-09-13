import 'package:animated_tree_view/animated_tree_view.dart';
import './utils.dart';
import 'package:flutter/material.dart';

///
///treeview_indexed_modification_sample.dart
///
class CatTreePage extends StatefulWidget {
  const CatTreePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CatTreePageState createState() => _CatTreePageState();
}

class _CatTreePageState extends State<CatTreePage> {
  static const _showRootNode = true;
  late final tree = IndexedTreeNode.root();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TreeView.indexed(
              tree: IndexedTreeNode.root(),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              showRootNode: _showRootNode,
              builder: buildListItem,
            ),
            if (!_showRootNode)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton.icon(
                    onPressed: () => tree.add(IndexedTreeNode()),
                    icon: const Icon(Icons.add),
                    label: const Text("Add Node")),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildListItem(BuildContext context, IndexedTreeNode node) {
    final color = colorMapper[node.level.clamp(0, colorMapper.length - 1)]!;
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                "Item ${node.level}-${node.key}",
                style: TextStyle(color: color.byLuminance()),
              ),
              subtitle: Text(
                'Level ${node.level}',
                style: TextStyle(color: color.byLuminance().withOpacity(0.5)),
              ),
              trailing: !node.isRoot ? buildRemoveItemButton(node) : null,
            ),
            if (!node.isRoot)
              FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildAddItemChildButton(node),
                    buildInsertAboveButton(node),
                    buildInsertBelowButton(node),
                  ],
                ),
              ),
            if (node.isRoot)
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildAddItemChildButton(node),
                  if (node.children.isNotEmpty) buildClearAllItemButton(node),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildAddItemChildButton(IndexedTreeNode item) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green[800],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        icon: const Icon(Icons.add_circle, color: Colors.green),
        label: const Text("Child", style: TextStyle(color: Colors.green)),
        onPressed: () => item.add(IndexedTreeNode()),
      ),
    );
  }

  Widget buildInsertAboveButton(IndexedTreeNode item) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green[800],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        child:
            const Text("Insert Above", style: TextStyle(color: Colors.green)),
        onPressed: () {
          item.parent?.insertBefore(item, IndexedTreeNode());
        },
      ),
    );
  }

  Widget buildInsertBelowButton(IndexedTreeNode item) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.green[800],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
        ),
        child:
            const Text("Insert Below", style: TextStyle(color: Colors.green)),
        onPressed: () {
          item.parent?.insertAfter(item, IndexedTreeNode());
        },
      ),
    );
  }

  Widget buildRemoveItemButton(IndexedTreeNode item) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red[800],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          child: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => item.delete()),
    );
  }

  Widget buildClearAllItemButton(IndexedTreeNode item) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: TextButton.icon(
          style: TextButton.styleFrom(
            foregroundColor: Colors.red[800],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ),
          icon: const Icon(Icons.delete, color: Colors.red),
          label: const Text("Clear All", style: TextStyle(color: Colors.red)),
          onPressed: () => item.clear()),
    );
  }
}

String cats = '''
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
