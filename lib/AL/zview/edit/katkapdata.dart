List<String> keywords = [];

void getKeywords() {
  keywords = [];
  for (var el in katKapPB) {
    keywords.add(
        '${el["kategorie"]} \n${el["kapitola"]} [${el["katKap"].toString().trim()}]');
  }
}

var katKapPB = [
  {
    "katKap": 1.1,
    "kat": 1,
    "kategorie": "Přehled hledání",
    "kap": 1,
    "kapitola": "Co je hledání",
    "ID": 2,
    "chapter": "What the Quest Is"
  },
  {
    "katKap": 1.2,
    "kat": 1,
    "kategorie": "Přehled hledání",
    "kap": 2,
    "kapitola": "Jeho volba",
    "ID": 3,
    "chapter": "Its Choice"
  },
  {
    "katKap": 1.3,
    "kat": 1,
    "kategorie": "Přehled hledání",
    "kap": 3,
    "kapitola": "Nezávislá cesta",
    "ID": 4,
    "chapter": "Independent Path"
  },
  {
    "katKap": 1.4,
    "kat": 1,
    "kategorie": "Přehled hledání",
    "kap": 4,
    "kapitola": "Organizované skupiny",
    "ID": 5,
    "chapter": "Organized Groups"
  },
  {
    "katKap": 1.5,
    "kat": 1,
    "kategorie": "Přehled hledání",
    "kap": 5,
    "kapitola": "Seberozvoj",
    "ID": 6,
    "chapter": "Self.Development"
  },
  {
    "katKap": 1.6,
    "kat": 1,
    "kategorie": "Přehled hledání",
    "kap": 6,
    "kapitola": "Student.učitel",
    "ID": 7,
    "chapter": "Student.Teacher"
  },
  {
    "katKap": 2.1,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 1,
    "kapitola": "Mravenčí dlouhá cesta",
    "ID": 8,
    "chapter": "Ant's Long Path"
  },
  {
    "katKap": 2.2,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 2,
    "kapitola": "Míra pokroku",
    "ID": 9,
    "chapter": "The Measure of Progress"
  },
  {
    "katKap": 2.3,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 3,
    "kapitola": "Nejistoty pokroku",
    "ID": 10,
    "chapter": "Uncertainties of Progress"
  },
  {
    "katKap": 2.4,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 4,
    "kapitola": "Cvičte mentální disciplínu",
    "ID": 11,
    "chapter": "Practise Mental Discipline"
  },
  {
    "katKap": 2.5,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 5,
    "kapitola": "Vyrovnat psychiku",
    "ID": 12,
    "chapter": "Balance the Psyche"
  },
  {
    "katKap": 1.3,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 6,
    "kapitola": "Sebereflexe a jednání",
    "ID": 13,
    "chapter": "Self.Reflection and Action"
  },
  {
    "katKap": 2.7,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 7,
    "kapitola": "Disciplína Touhy",
    "ID": 14,
    "chapter": "Discipline Desires"
  },
  {
    "katKap": 2.8,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 8,
    "kapitola": "Hledání a společenská odpovědnost",
    "ID": 15,
    "chapter": "The Quest and Social Responsibility"
  },
  {
    "katKap": 2.9,
    "kat": 2,
    "kategorie": "Přehled zapojených praktik",
    "kap": 9,
    "kapitola": "Závěr",
    "ID": 16,
    "chapter": "Conclusion"
  },
  {
    "katKap": 3.1,
    "kat": 3,
    "kategorie": "Relax a ústraní",
    "kap": 1,
    "kapitola": "Dělejte přerušované pauzy",
    "ID": 17,
    "chapter": "Take Intermittent Pauses"
  },
  {
    "katKap": 3.2,
    "kat": 3,
    "kategorie": "Relax a ústraní",
    "kap": 2,
    "kapitola": "Vytáhněte z napětí a tlaku",
    "ID": 18,
    "chapter": "Withdraw from Tension and Pressure"
  },
  {
    "katKap": 3.3,
    "kat": 3,
    "kategorie": "Relax a ústraní",
    "kap": 3,
    "kapitola": "Uvolněte tělo, dech, mysl",
    "ID": 19,
    "chapter": "Relax Body, Breath, Mind"
  },
  {
    "katKap": 3.4,
    "kat": 3,
    "kategorie": "Relax a ústraní",
    "kap": 4,
    "kapitola": "Retreat Centers",
    "ID": 20,
    "chapter": "Retreat Centres"
  },
  {
    "katKap": 3.5,
    "kat": 3,
    "kategorie": "Relax a ústraní",
    "kap": 5,
    "kapitola": "Samota",
    "ID": 21,
    "chapter": "Solitude"
  },
  {
    "katKap": 3.6,
    "kat": 3,
    "kategorie": "Relax a ústraní",
    "kap": 6,
    "kapitola": "Ocenění přírody",
    "ID": 22,
    "chapter": "Nature Appreciation"
  },
  {
    "katKap": 3.7,
    "kat": 3,
    "kategorie": "Relax a ústraní",
    "kap": 7,
    "kapitola": "Kontemplace západu slunce",
    "ID": 23,
    "chapter": "Sunset Contemplation"
  },
  {
    "katKap": 4.1,
    "kat": 4,
    "kategorie": "Elementární meditace",
    "kap": 1,
    "kapitola": "Přípravné",
    "ID": 24,
    "chapter": "Preparatory"
  },
  {
    "katKap": 4.2,
    "kat": 4,
    "kategorie": "Elementární meditace",
    "kap": 2,
    "kapitola": "Místo a stav",
    "ID": 25,
    "chapter": "Place and Condition"
  },
  {
    "katKap": 4.3,
    "kat": 4,
    "kategorie": "Elementární meditace",
    "kap": 3,
    "kapitola": "Základy",
    "ID": 26,
    "chapter": "Fundamentals"
  },
  {
    "katKap": 4.4,
    "kat": 4,
    "kategorie": "Elementární meditace",
    "kap": 4,
    "kapitola": "Meditativní myšlení",
    "ID": 27,
    "chapter": "Meditative Thinking"
  },
  {
    "katKap": 4.5,
    "kat": 4,
    "kategorie": "Elementární meditace",
    "kap": 5,
    "kapitola": "Vizualizace, symboly",
    "ID": 28,
    "chapter": "Visualizations, Symbols"
  },
  {
    "katKap": 4.6,
    "kat": 4,
    "kategorie": "Elementární meditace",
    "kap": 6,
    "kapitola": "Mantramy, afirmace",
    "ID": 29,
    "chapter": "Mantrams, Affirmations"
  },
  {
    "katKap": 4.7,
    "kat": 4,
    "kategorie": "Elementární meditace",
    "kap": 7,
    "kapitola": "Všímavost, duševní klid",
    "ID": 30,
    "chapter": "Mindfulness, Mental Quiet"
  },
  {
    "katKap": 5.1,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 1,
    "kapitola": "Prefační",
    "ID": 31,
    "chapter": "Prefatory"
  },
  {
    "katKap": 5.2,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 2,
    "kapitola": "Tělo",
    "ID": 32,
    "chapter": "The Body"
  },
  {
    "katKap": 5.3,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 3,
    "kapitola": "Dieta",
    "ID": 33,
    "chapter": "Diet"
  },
  {
    "katKap": 5.4,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 4,
    "kapitola": "Půst",
    "ID": 34,
    "chapter": "Fasting"
  },
  {
    "katKap": 5.5,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 5,
    "kapitola": "Cvičení",
    "ID": 35,
    "chapter": "Exercise"
  },
  {
    "katKap": 5.6,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 6,
    "kapitola": "Dechová cvičení",
    "ID": 36,
    "chapter": "Breathing Exercises"
  },
  {
    "katKap": 5.7,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 7,
    "kapitola": "Sex",
    "ID": 37,
    "chapter": "Sex"
  },
  {
    "katKap": 5.8,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 8,
    "kapitola": "Kundaliní",
    "ID": 38,
    "chapter": "Kundalini"
  },
  {
    "katKap": 5.9,
    "kat": 5,
    "kategorie": "Tělo",
    "kap": 9,
    "kapitola": "Modlitba",
    "ID": 39,
    "chapter": "Prayer"
  },
  {
    "katKap": 6.1,
    "kat": 6,
    "kategorie": "Emoce a etika",
    "kap": 1,
    "kapitola": "Pozvedněte charakter",
    "ID": 40,
    "chapter": "Uplift Character"
  },
  {
    "katKap": 6.2,
    "kat": 6,
    "kategorie": "Emoce a etika",
    "kap": 2,
    "kapitola": "Převychovávejte pocity",
    "ID": 41,
    "chapter": "Re.Educate Feelings"
  },
  {
    "katKap": 6.3,
    "kat": 6,
    "kategorie": "Emoce a etika",
    "kap": 3,
    "kapitola": "Disciplína emocí",
    "ID": 42,
    "chapter": "Discipline Emotions"
  },
  {
    "katKap": 6.4,
    "kat": 6,
    "kategorie": "Emoce a etika",
    "kap": 4,
    "kapitola": "Očistěte vášně",
    "ID": 43,
    "chapter": "Purify Passions"
  },
  {
    "katKap": 6.5,
    "kat": 6,
    "kategorie": "Emoce a etika",
    "kap": 5,
    "kapitola": "Duchovní zušlechťování",
    "ID": 44,
    "chapter": "Spiritual Refinement"
  },
  {
    "katKap": 6.6,
    "kat": 6,
    "kategorie": "Emoce a etika",
    "kap": 6,
    "kapitola": "Vyhněte se fanatismu",
    "ID": 45,
    "chapter": "Avoid Fanaticism"
  },
  {
    "katKap": 6.7,
    "kat": 6,
    "kategorie": "Emoce a etika",
    "kap": 7,
    "kapitola": "Různé etické otázky",
    "ID": 46,
    "chapter": "Miscellaneous Ethical Issues"
  },
  {
    "katKap": 7.1,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 1,
    "kapitola": "Místo intelektu",
    "ID": 47,
    "chapter": "The Place of Intellect"
  },
  {
    "katKap": 7.2,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 2,
    "kapitola": "Služba intelektu",
    "ID": 48,
    "chapter": "The Service of Intellect"
  },
  {
    "katKap": 7.3,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 3,
    "kapitola": "Rozvoj intelektu",
    "ID": 49,
    "chapter": "The Development of Intellect"
  },
  {
    "katKap": 7.4,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 4,
    "kapitola": "Abstraktní myšlení",
    "ID": 50,
    "chapter": "Abstract Thought"
  },
  {
    "katKap": 7.5,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 5,
    "kapitola": "Sémantika",
    "ID": 51,
    "chapter": "Semantics"
  },
  {
    "katKap": 7.6,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 6,
    "kapitola": "Věda",
    "ID": 52,
    "chapter": "Science"
  },
  {
    "katKap": 7.7,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 7,
    "kapitola": "Metafyzika pravdy",
    "ID": 53,
    "chapter": "Metaphysics of Truth"
  },
  {
    "katKap": 7.8,
    "kat": 7,
    "kategorie": "Intelekt",
    "kap": 8,
    "kapitola": "Intelekt, realita a nadjá",
    "ID": 54,
    "chapter": "Intellect, Reality, and The Overself"
  },
  {
    "katKap": 8.1,
    "kat": 8,
    "kategorie": "Ego",
    "kap": 1,
    "kapitola": "Co jsem",
    "ID": 55,
    "chapter": "What Am I"
  },
  {
    "katKap": 8.2,
    "kat": 8,
    "kategorie": "Ego",
    "kap": 2,
    "kapitola": "Myslel jsem",
    "ID": 56,
    "chapter": "I.thought"
  },
  {
    "katKap": 8.3,
    "kat": 8,
    "kategorie": "Ego",
    "kap": 3,
    "kapitola": "Psychika",
    "ID": 57,
    "chapter": "Psyche"
  },
  {
    "katKap": 8.4,
    "kat": 8,
    "kategorie": "Ego",
    "kap": 4,
    "kapitola": "Odpojení od Ega",
    "ID": 58,
    "chapter": "Detaching from The Ego"
  },
  {
    "katKap": 9.1,
    "kat": 9,
    "kategorie": "Od narození ke znovuzrození",
    "kap": 1,
    "kapitola": "Smrt, umírání a nesmrtelnost",
    "ID": 59,
    "chapter": "Death, Dying, and Immortality"
  },
  {
    "katKap": 9.2,
    "kat": 9,
    "kategorie": "Od narození ke znovuzrození",
    "kap": 2,
    "kapitola": "Znovuzrození a reinkarnace",
    "ID": 60,
    "chapter": "Rebirth and Reincarnation"
  },
  {
    "katKap": 9.3,
    "kat": 9,
    "kategorie": "Od narození ke znovuzrození",
    "kap": 3,
    "kapitola": "Zákony a vzorce zkušenosti",
    "ID": 61,
    "chapter": "Laws and Patterns of Experience"
  },
  {
    "katKap": 9.4,
    "kat": 9,
    "kategorie": "Od narození ke znovuzrození",
    "kap": 4,
    "kapitola": "Svobodná vůle, odpovědnost a světová myšlenka",
    "ID": 62,
    "chapter": "Free Will, Responsibility, and The World.Idea"
  },
  {
    "katKap": 10.1,
    "kat": 10,
    "kategorie": "Uzdravení Já",
    "kap": 1,
    "kapitola": "Přírodní zákony",
    "ID": 63,
    "chapter": "The Laws of Nature"
  },
  {
    "katKap": 10.2,
    "kat": 10,
    "kategorie": "Uzdravení Já",
    "kap": 2,
    "kapitola": "Univerzální životní síla",
    "ID": 64,
    "chapter": "The Universal Life Force"
  },
  {
    "katKap": 10.3,
    "kat": 10,
    "kategorie": "Uzdravení Já",
    "kap": 3,
    "kapitola": "Původ nemoci",
    "ID": 65,
    "chapter": "The Origins of Illness"
  },
  {
    "katKap": 10.4,
    "kat": 10,
    "kategorie": "Uzdravení Já",
    "kap": 4,
    "kapitola": "Léčitelé těla a mysli",
    "ID": 66,
    "chapter": "Healers of The Body and Mind"
  },
  {
    "katKap": 10.5,
    "kat": 10,
    "kategorie": "Uzdravení Já",
    "kap": 5,
    "kapitola": "Léčivá síla Nadjá",
    "ID": 67,
    "chapter": "The Healing Power of The Overself"
  },
  {
    "katKap": 11.1,
    "kat": 11,
    "kategorie": "Negativa",
    "kap": 1,
    "kapitola": "Jejich povaha",
    "ID": 68,
    "chapter": "Their Nature"
  },
  {
    "katKap": 11.2,
    "kat": 11,
    "kategorie": "Negativa",
    "kap": 2,
    "kapitola": "Jejich kořeny v egu",
    "ID": 69,
    "chapter": "Their Roots in Ego"
  },
  {
    "katKap": 11.3,
    "kat": 11,
    "kategorie": "Negativa",
    "kap": 3,
    "kapitola": "Jejich přítomnost ve světě",
    "ID": 70,
    "chapter": "Their Presence in The World"
  },
  {
    "katKap": 11.4,
    "kat": 11,
    "kategorie": "Negativa",
    "kap": 4,
    "kapitola": "V myšlenkách, citech, násilných vášních",
    "ID": 71,
    "chapter": "In Thoughts, Feelings, Violent Passions"
  },
  {
    "katKap": 11.5,
    "kat": 11,
    "kategorie": "Negativa",
    "kap": 5,
    "kapitola": "Jejich viditelné a neviditelné poškození",
    "ID": 72,
    "chapter": "Their Visible and Invisible Harm"
  },
  {
    "katKap": 12.1,
    "kat": 12,
    "kategorie": "Úvahy",
    "kap": 1,
    "kapitola": "Dva eseje",
    "ID": 73,
    "chapter": "Two Essays"
  },
  {
    "katKap": 12.2,
    "kat": 12,
    "kategorie": "Úvahy",
    "kap": 2,
    "kapitola": "Filosofie a současná kultura",
    "ID": 74,
    "chapter": "Philosophy and Contemporary Culture"
  },
  {
    "katKap": 12.3,
    "kat": 12,
    "kategorie": "Úvahy",
    "kap": 3,
    "kapitola": "Setkání s osudem",
    "ID": 75,
    "chapter": "Encounter With Destiny"
  },
  {
    "katKap": 12.4,
    "kat": 12,
    "kategorie": "Úvahy",
    "kap": 4,
    "kapitola": "Úvahy o pravdě",
    "ID": 76,
    "chapter": "Reflections On Truth"
  },
  {
    "katKap": 12.5,
    "kat": 12,
    "kategorie": "Úvahy",
    "kap": 5,
    "kapitola": "Literární dílo",
    "ID": 77,
    "chapter": "The Literary Work"
  },
  {
    "katKap": 12.6,
    "kat": 12,
    "kategorie": "Úvahy",
    "kap": 6,
    "kapitola": "Profánní a hluboký",
    "ID": 78,
    "chapter": "The Profane and The Profound"
  },
  {
    "katKap": 13.1,
    "kat": 13,
    "kategorie": "Lidská zkušenost",
    "kap": 1,
    "kapitola": "Situace",
    "ID": 79,
    "chapter": "Situation"
  },
  {
    "katKap": 13.2,
    "kat": 13,
    "kategorie": "Lidská zkušenost",
    "kap": 2,
    "kapitola": "Život ve světě",
    "ID": 80,
    "chapter": "Living in The World"
  },
  {
    "katKap": 13.3,
    "kat": 13,
    "kategorie": "Lidská zkušenost",
    "kap": 3,
    "kapitola": "Mládí a věk",
    "ID": 81,
    "chapter": "Youth and Age"
  },
  {
    "katKap": 13.4,
    "kat": 13,
    "kategorie": "Lidská zkušenost",
    "kap": 4,
    "kapitola": "Světová krize",
    "ID": 82,
    "chapter": "World Crisis"
  },
  {
    "katKap": 14.1,
    "kat": 14,
    "kategorie": "Umění v kultuře",
    "kap": 1,
    "kapitola": "Ocenění",
    "ID": 83,
    "chapter": "Appreciation"
  },
  {
    "katKap": 14.2,
    "kat": 14,
    "kategorie": "Umění v kultuře",
    "kap": 2,
    "kapitola": "Kreativita, genialita",
    "ID": 84,
    "chapter": "Creativity, Genius"
  },
  {
    "katKap": 14.3,
    "kat": 14,
    "kategorie": "Umění v kultuře",
    "kap": 3,
    "kapitola": "Umělecká zkušenost a mystika",
    "ID": 85,
    "chapter": "Art Experience and Mysticism"
  },
  {
    "katKap": 14.4,
    "kat": 14,
    "kategorie": "Umění v kultuře",
    "kap": 4,
    "kapitola": "Úvahy o specifických uměních",
    "ID": 86,
    "chapter": "Reflections On Specific Arts"
  },
  {
    "katKap": 15.1,
    "kat": 15,
    "kategorie": "Orient",
    "kap": 1,
    "kapitola": "Setkání Východu a Západu",
    "ID": 87,
    "chapter": "Meetings of East and West"
  },
  {
    "katKap": 15.2,
    "kat": 15,
    "kategorie": "Orient",
    "kap": 2,
    "kapitola": "Indie",
    "ID": 88,
    "chapter": "India"
  },
  {
    "katKap": 15.3,
    "kat": 15,
    "kategorie": "Orient",
    "kap": 3,
    "kapitola": "Čína, Japonsko, Tibet",
    "ID": 89,
    "chapter": "China, Japan, Tibet"
  },
  {
    "katKap": 15.4,
    "kat": 15,
    "kategorie": "Orient",
    "kap": 4,
    "kapitola": "Cejlon, Angkor Wat, Barma, Jáva",
    "ID": 90,
    "chapter": "Ceylon, Angkor Wat, Burma, Java"
  },
  {
    "katKap": 15.5,
    "kat": 15,
    "kategorie": "Orient",
    "kap": 5,
    "kapitola": "Islámské kultury, Egypt",
    "ID": 91,
    "chapter": "Islamic Cultures, Egypt"
  },
  {
    "katKap": 15.6,
    "kat": 15,
    "kategorie": "Orient",
    "kap": 6,
    "kapitola": "Související položky",
    "ID": 92,
    "chapter": "Related Entries"
  },
  {
    "katKap": 16.1,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 1,
    "kapitola": "Mystický život v moderním světě",
    "ID": 93,
    "chapter": "Mystical Life in The Modern World"
  },
  {
    "katKap": 16.2,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 2,
    "kapitola": "Fáze mystického vývoje",
    "ID": 94,
    "chapter": "Phases of Mystical Development"
  },
  {
    "katKap": 16.3,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 3,
    "kapitola": "Filosofie, mystika a okultismus",
    "ID": 95,
    "chapter": "Philosophy, Mysticism, and The Occult"
  },
  {
    "katKap": 16.4,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 4,
    "kapitola": "Ti, kteří hledají",
    "ID": 96,
    "chapter": "Those Who Seek"
  },
  {
    "katKap": 16.5,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 5,
    "kapitola": "Pseudo a nedokonalí učitelé",
    "ID": 97,
    "chapter": "Pseudo and Imperfect Teachers"
  },
  {
    "katKap": 16.6,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 6,
    "kapitola": "Bludy a bolestivá probuzení",
    "ID": 98,
    "chapter": "Delusions and Painful Awakenings"
  },
  {
    "katKap": 16.7,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 7,
    "kapitola": "Cesta individuality",
    "ID": 99,
    "chapter": "The Path of Individuality"
  },
  {
    "katKap": 16.8,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 8,
    "kapitola": "Křesťanská věda, jiná duchovní hnutí",
    "ID": 100,
    "chapter": "Christian Science, Other Spiritual Movements"
  },
  {
    "katKap": 16.9,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 9,
    "kapitola": "Inspirace a zmatek",
    "ID": 101,
    "chapter": "Inspiration and Confusion"
  },
  {
    "katKap": 16.1,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 10,
    "kapitola": "10. Is Není Ism",
    "ID": 102,
    "chapter": "10. The Is Is Not an Ism"
  },
  {
    "katKap": 16.11,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 11,
    "kapitola": "11. Fanatismus, peníze, moc, drogy“",
    "ID": 103,
    "chapter": "11. Fanaticism, Money, Powers, Drugs"
  },
  {
    "katKap": 16.12,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 12,
    "kapitola": "12. Mezizóna",
    "ID": 104,
    "chapter": "12. The Intermediate Zone"
  },
  {
    "katKap": 16.13,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 13,
    "kapitola": "13. Okultismus",
    "ID": 105,
    "chapter": "13. The Occult"
  },
  {
    "katKap": 16.14,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 14,
    "kapitola": "14. Citlivá mysl",
    "ID": 106,
    "chapter": "14. The Sensitive Mind"
  },
  {
    "katKap": 16.15,
    "kat": 16,
    "kategorie": "Sensitives",
    "kap": 15,
    "kapitola": "15. Iluminace",
    "ID": 107,
    "chapter": "15. Illuminations"
  },
  {
    "katKap": 17.1,
    "kat": 17,
    "kategorie": "Náboženské nutkání",
    "kap": 1,
    "kapitola": "Původ, účel náboženství",
    "ID": 108,
    "chapter": "Origin, Purpose of Religions"
  },
  {
    "katKap": 17.2,
    "kat": 17,
    "kategorie": "Náboženské nutkání",
    "kap": 2,
    "kapitola": "Organizace, obsah náboženství",
    "ID": 109,
    "chapter": "Organization, Content of Religion"
  },
  {
    "katKap": 17.3,
    "kat": 17,
    "kategorie": "Náboženské nutkání",
    "kap": 3,
    "kapitola": "Náboženství jako příprava",
    "ID": 110,
    "chapter": "Religion As Preparatory"
  },
  {
    "katKap": 17.4,
    "kat": 17,
    "kategorie": "Náboženské nutkání",
    "kap": 4,
    "kapitola": "Problémy organizovaného náboženství",
    "ID": 111,
    "chapter": "Problems of Organized Religion"
  },
  {
    "katKap": 17.5,
    "kat": 17,
    "kategorie": "Náboženské nutkání",
    "kap": 5,
    "kapitola": "Komentáře ke konkrétním náboženstvím",
    "ID": 112,
    "chapter": "Comments On Specific Religions"
  },
  {
    "katKap": 17.6,
    "kat": 17,
    "kategorie": "Náboženské nutkání",
    "kap": 6,
    "kapitola": "Filosofie a náboženství",
    "ID": 113,
    "chapter": "Philosophy and Religion"
  },
  {
    "katKap": 17.7,
    "kat": 17,
    "kategorie": "Náboženské nutkání",
    "kap": 7,
    "kapitola": "Za náboženstvím, jak ho známe",
    "ID": 114,
    "chapter": "Beyond Religion As We Know It"
  },
  {
    "katKap": 18.1,
    "kat": 18,
    "kategorie": "Ctihodný život",
    "kap": 1,
    "kapitola": "Oddanost",
    "ID": 115,
    "chapter": "Devotion"
  },
  {
    "katKap": 18.2,
    "kat": 18,
    "kategorie": "Ctihodný život",
    "kap": 2,
    "kapitola": "Modlitba",
    "ID": 116,
    "chapter": "Prayer"
  },
  {
    "katKap": 18.3,
    "kat": 18,
    "kategorie": "Ctihodný život",
    "kap": 3,
    "kapitola": "Pokora",
    "ID": 117,
    "chapter": "Humility"
  },
  {
    "katKap": 18.4,
    "kat": 18,
    "kategorie": "Ctihodný život",
    "kap": 4,
    "kapitola": "Vzdejte se",
    "ID": 118,
    "chapter": "Surrender"
  },
  {
    "katKap": 18.5,
    "kat": 18,
    "kategorie": "Ctihodný život",
    "kap": 5,
    "kapitola": "Milost",
    "ID": 119,
    "chapter": "Grace"
  },
  {
    "katKap": 19.1,
    "kat": 19,
    "kategorie": "Vláda Relativity",
    "kap": 1,
    "kapitola": "Kosmos změny",
    "ID": 120,
    "chapter": "The Cosmos of Change"
  },
  {
    "katKap": 19.2,
    "kat": 19,
    "kategorie": "Vláda Relativity",
    "kap": 2,
    "kapitola": "Dvojité stanovisko",
    "ID": 121,
    "chapter": "The Double Standpoint"
  },
  {
    "katKap": 19.3,
    "kat": 19,
    "kategorie": "Vláda Relativity",
    "kap": 3,
    "kapitola": "Stavy vědomí",
    "ID": 122,
    "chapter": "The States of Consciousness"
  },
  {
    "katKap": 19.4,
    "kat": 19,
    "kategorie": "Vláda Relativity",
    "kap": 4,
    "kapitola": "Čas, prostor, kauzalita",
    "ID": 123,
    "chapter": "Time, Space, Causality"
  },
  {
    "katKap": 19.5,
    "kat": 19,
    "kategorie": "Vláda Relativity",
    "kap": 5,
    "kapitola": "Prázdnota jako metafyzický fakt",
    "ID": 124,
    "chapter": "The Void As Metaphysical Fact"
  },
  {
    "katKap": 20.1,
    "kat": 20,
    "kategorie": "Co je filozofie?",
    "kap": 1,
    "kapitola": "Směrem k definování filozofie",
    "ID": 125,
    "chapter": "Toward Defining Philosophy"
  },
  {
    "katKap": 20.2,
    "kat": 20,
    "kategorie": "Co je filozofie?",
    "kap": 2,
    "kapitola": "Jeho současný vliv",
    "ID": 126,
    "chapter": "Its Contemporary Influence"
  },
  {
    "katKap": 20.3,
    "kat": 20,
    "kategorie": "Co je filozofie?",
    "kap": 3,
    "kapitola": "Jeho požadavky",
    "ID": 127,
    "chapter": "Its Requirements"
  },
  {
    "katKap": 20.4,
    "kat": 20,
    "kategorie": "Co je filozofie?",
    "kap": 4,
    "kapitola": "Jeho realizace mimo extázi",
    "ID": 128,
    "chapter": "Its Realization Beyond Ecstasy"
  },
  {
    "katKap": 20.5,
    "kat": 20,
    "kategorie": "Co je filozofie?",
    "kap": 5,
    "kapitola": "Filozof",
    "ID": 129,
    "chapter": "The Philosopher"
  },
  {
    "katKap": 21.1,
    "kat": 21,
    "kategorie": "Mentalismus",
    "kap": 1,
    "kapitola": "Sensed World",
    "ID": 130,
    "chapter": "The Sensed World"
  },
  {
    "katKap": 21.2,
    "kat": 21,
    "kategorie": "Mentalismus",
    "kap": 2,
    "kapitola": "Svět jako mentální",
    "ID": 131,
    "chapter": "The World As Mental"
  },
  {
    "katKap": 21.3,
    "kat": 21,
    "kategorie": "Mentalismus",
    "kap": 3,
    "kapitola": "Individuální a světová mysl",
    "ID": 132,
    "chapter": "The Individual and World Mind"
  },
  {
    "katKap": 21.4,
    "kat": 21,
    "kategorie": "Mentalismus",
    "kap": 4,
    "kapitola": "Výzva mentalismu",
    "ID": 133,
    "chapter": "The Challenge of Mentalism"
  },
  {
    "katKap": 21.5,
    "kat": 21,
    "kategorie": "Mentalismus",
    "kap": 5,
    "kapitola": "Klíč k duchovnímu světu",
    "ID": 134,
    "chapter": "The Key To the Spiritual World"
  },
  {
    "katKap": 22.1,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 1,
    "kapitola": "Intuice na začátku",
    "ID": 135,
    "chapter": "Intuition the Beginning"
  },
  {
    "katKap": 22.2,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 2,
    "kapitola": "Inspirace",
    "ID": 136,
    "chapter": "Inspiration"
  },
  {
    "katKap": 22.3,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 3,
    "kapitola": "Přítomnost Nadjá",
    "ID": 137,
    "chapter": "The Overself's Presence"
  },
  {
    "katKap": 22.4,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 4,
    "kapitola": "Úvod do mystických pohledů",
    "ID": 138,
    "chapter": "Introduction To Mystical Glimpses"
  },
  {
    "katKap": 22.5,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 5,
    "kapitola": "Příprava na letmé pohledy",
    "ID": 139,
    "chapter": "Preparing for Glimpses"
  },
  {
    "katKap": 22.6,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 6,
    "kapitola": "Zažijte letmý pohled",
    "ID": 140,
    "chapter": "Experiencing a Glimpse"
  },
  {
    "katKap": 22.7,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 7,
    "kapitola": "After the Glimpse",
    "ID": 141,
    "chapter": "After the Glimpse"
  },
  {
    "katKap": 22.8,
    "kat": 22,
    "kategorie": "Inspirace a Nadjá",
    "kap": 8,
    "kapitola": "Záblesky a trvalé osvětlení",
    "ID": 142,
    "chapter": "Glimpses and Permanent Illumination"
  },
  {
    "katKap": 23.1,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 1,
    "kapitola": "Zadání krátké cesty",
    "ID": 143,
    "chapter": "Entering the Short Path"
  },
  {
    "katKap": 23.2,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 2,
    "kapitola": "Úskalí a omezení",
    "ID": 144,
    "chapter": "Pitfalls and Limitations"
  },
  {
    "katKap": 23.3,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 3,
    "kapitola": "Temná noc duše",
    "ID": 145,
    "chapter": "The Dark Night of The Soul"
  },
  {
    "katKap": 23.4,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 4,
    "kapitola": "Přechod na krátkou cestu",
    "ID": 146,
    "chapter": "The Changeover To the Short Path"
  },
  {
    "katKap": 23.5,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 5,
    "kapitola": "Vyvažování cest",
    "ID": 147,
    "chapter": "Balancing the Paths"
  },
  {
    "katKap": 23.6,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 6,
    "kapitola": "Pokročilá meditace",
    "ID": 148,
    "chapter": "Advanced Meditation"
  },
  {
    "katKap": 23.7,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 7,
    "kapitola": "Kontemplativní klid",
    "ID": 149,
    "chapter": "Contemplative Stillness"
  },
  {
    "katKap": 23.8,
    "kat": 23,
    "kategorie": "Pokročilá kontemplace",
    "kap": 8,
    "kapitola": "Prázdnota jako kontemplativní zkušenost",
    "ID": 150,
    "chapter": "The Void As Contemplative Experience"
  },
  {
    "katKap": 24.1,
    "kat": 24,
    "kategorie": "Mír ve vás",
    "kap": 1,
    "kapitola": "Hledání štěstí",
    "ID": 151,
    "chapter": "The Search for Happiness"
  },
  {
    "katKap": 24.2,
    "kat": 24,
    "kategorie": "Mír ve vás",
    "kap": 2,
    "kapitola": "Buďte klidní",
    "ID": 152,
    "chapter": "Be Calm"
  },
  {
    "katKap": 24.3,
    "kat": 24,
    "kategorie": "Mír ve vás",
    "kap": 3,
    "kapitola": "Cvičte oddělení",
    "ID": 153,
    "chapter": "Practise Detachment"
  },
  {
    "katKap": 24.4,
    "kat": 24,
    "kategorie": "Mír ve vás",
    "kap": 4,
    "kapitola": "Hledejte hlubší klid",
    "ID": 154,
    "chapter": "Seek the Deeper Stillness"
  },
  {
    "katKap": 25.1,
    "kat": 25,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 1,
    "kapitola": "Jejich setkání a výměna",
    "ID": 155,
    "chapter": "Their Meeting and Interchange"
  },
  {
    "katKap": 25.2,
    "kat": 25,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 2,
    "kapitola": "Osvícení, které zůstane",
    "ID": 156,
    "chapter": "Enlightenment Which Stays"
  },
  {
    "katKap": 25.3,
    "kat": 25,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 3,
    "kapitola": "Mudrc",
    "ID": 157,
    "chapter": "The Sage"
  },
  {
    "katKap": 25.4,
    "kat": 25,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 4,
    "kapitola": "Služba mudrce",
    "ID": 158,
    "chapter": "The Sage's Service"
  },
  {
    "katKap": 25.5,
    "kat": 25,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 5,
    "kapitola": "Učitelé, učednictví",
    "ID": 159,
    "chapter": "Teaching Masters, Discipleship"
  },
  {
    "katKap": 26.1,
    "kat": 26,
    "kategorie": "Světová myšlenka",
    "kap": 1,
    "kapitola": "Božský řád vesmíru",
    "ID": 160,
    "chapter": "Divine Order of The Universe"
  },
  {
    "katKap": 26.2,
    "kat": 26,
    "kategorie": "Světová myšlenka",
    "kap": 2,
    "kapitola": "Změna jako univerzální aktivita",
    "ID": 161,
    "chapter": "Change As Universal Activity"
  },
  {
    "katKap": 26.3,
    "kat": 26,
    "kategorie": "Světová myšlenka",
    "kap": 3,
    "kapitola": "Polarity, komplementáře, duality vesmíru",
    "ID": 162,
    "chapter": "Polarities, Complementaries, Dualities of The Universe"
  },
  {
    "katKap": 26.4,
    "kat": 26,
    "kategorie": "Světová myšlenka",
    "kap": 4,
    "kapitola": "Pravá představa člověka",
    "ID": 163,
    "chapter": "True Idea of Man"
  },
  {
    "katKap": 27.1,
    "kat": 27,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 1,
    "kapitola": "Co je Bůh?",
    "ID": 164,
    "chapter": "What Is God?"
  },
  {
    "katKap": 27.2,
    "kat": 27,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 2,
    "kapitola": "Povaha světové mysli",
    "ID": 165,
    "chapter": "Nature of World-Mind"
  },
  {
    "katKap": 27.3,
    "kat": 27,
    "kategorie": "Světová mysl v individuální mysli",
    "kap": 3,
    "kapitola": "Světová mysl a ,,Stvoření``",
    "ID": 166,
    "chapter": "World-Mind and ``Creation``"
  },
  {
    "katKap": 28.1,
    "kat": 28,
    "kategorie": "Sám",
    "kap": 1,
    "kapitola": "Absolutní mysl",
    "ID": 167,
    "chapter": "Absolute Mind"
  },
  {
    "katKap": 28.2,
    "kat": 28,
    "kategorie": "Sám",
    "kap": 2,
    "kapitola": "Náš vztah k Absolutnu",
    "ID": 168,
    "chapter": "Our Relation To the Absolute"
  },
  {
    "katKap": 0,
    "kat": 0,
    "kategorie": "Perspektivy",
    "kap": 1,
    "kapitola": "Přehled úkolu",
    "ID": 169,
    "chapter": "Overview of the Quest"
  }
];
