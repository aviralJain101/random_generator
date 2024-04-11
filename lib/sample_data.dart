import 'map_data.dart';

class SampleData {
// Sample English sounds to Hiragana character mappings
  static final Map<String, dynamic> englishSoundsToHiraganaMapping = {
    'a': 'あ',
    'i': 'い',
    'u': 'う',
    'e': 'え',
    'o': 'お',
    'ka': 'か',
    'ki': 'き',
    'ku': 'く',
    'ke': 'け',
    'ko': 'こ',
    'sa': 'さ',
    'shi': 'し',
    'su': 'す',
    'se': 'せ',
    'so': 'そ',
    'ta': 'た',
    'chi': 'ち',
    'tsu': 'つ',
    'te': 'て',
    'to': 'と',
    'na': 'な',
    'ni': 'に',
    'nu': 'ぬ',
    'ne': 'ね',
    'no': 'の',
    'ha': 'は',
    'hi': 'ひ',
    'fu': 'ふ',
    'he': 'へ',
    'ho': 'ほ',
    'ma': 'ま',
    'mi': 'み',
    'mu': 'む',
    'me': 'め',
    'mo': 'も',
    'ya': 'や',
    'yu': 'ゆ',
    'yo': 'よ',
    'ra': 'ら',
    'ri': 'り',
    'ru': 'る',
    're': 'れ',
    'ro': 'ろ',
    'wa': 'わ',
    'wo': 'を',
    'n': 'ん',
  };

// Sample Hiragana to English sounds mappings
  static final Map<String, dynamic> hiraganaToEnglishSoundsMapping = {
    'あ': 'a',
    'い': 'i',
    'う': 'u',
    'え': 'e',
    'お': 'o',
    'か': 'ka',
    'き': 'ki',
    'く': 'ku',
    'け': 'ke',
    'こ': 'ko',
    'さ': 'sa',
    'し': 'shi',
    'す': 'su',
    'せ': 'se',
    'そ': 'so',
    'た': 'ta',
    'ち': 'chi',
    'つ': 'tsu',
    'て': 'te',
    'と': 'to',
    'な': 'na',
    'に': 'ni',
    'ぬ': 'nu',
    'ね': 'ne',
    'の': 'no',
    'は': 'ha',
    'ひ': 'hi',
    'ふ': 'fu',
    'へ': 'he',
    'ほ': 'ho',
    'ま': 'ma',
    'み': 'mi',
    'む': 'mu',
    'め': 'me',
    'も': 'mo',
    'や': 'ya',
    'ゆ': 'yu',
    'よ': 'yo',
    'ら': 'ra',
    'り': 'ri',
    'る': 'ru',
    'れ': 're',
    'ろ': 'ro',
    'わ': 'wa',
    'を': 'wo',
    'ん': 'n',
  };

  static List<MapData> getSampleData(){
    final MapData hiraganaToEnglishSoundsMapData = MapData('Hiragana to English Sounds Map', hiraganaToEnglishSoundsMapping);
    final MapData englishSoundsToHiraganaMapData = MapData('English Sounds to Hiragana Map', englishSoundsToHiraganaMapping);

    final Map<String, dynamic> mixedMap = {}..addAll(englishSoundsToHiraganaMapData.data)..addAll(hiraganaToEnglishSoundsMapData.data);
    final MapData englishAndHiraganaMixMapData = MapData("English and Hiragana mix", mixedMap);

    return [hiraganaToEnglishSoundsMapData, englishSoundsToHiraganaMapData, englishAndHiraganaMixMapData];
  }

}
