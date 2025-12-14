import 'package:flutter/material.dart';

class CountryUtils {
  // Get flag colors for ALL 195 UN member states
  static List<Color> getFlagColors(String countryCode) {
    switch (countryCode.toUpperCase()) {
      // ========== AFRICA (54 COUNTRIES) ==========
      case 'DZ': // Algeria
        return [Colors.green, Colors.white, Colors.red];
      case 'AO': // Angola
        return [Colors.black, Colors.red, Colors.yellow];
      case 'BJ': // Benin
        return [Colors.green, Colors.yellow, Colors.red];
      case 'BW': // Botswana
        return [Colors.blue, Colors.black, Colors.white];
      case 'BF': // Burkina Faso
        return [Colors.red, Colors.green, Colors.yellow];
      case 'BI': // Burundi
        return [Colors.red, Colors.green, Colors.white];
      case 'CV': // Cape Verde
        return [Colors.blue, Colors.white, Colors.red];
      case 'CM': // Cameroon
        return [Colors.green, Colors.red, Colors.yellow];
      case 'CF': // Central African Republic
        return [
          Colors.blue,
          Colors.white,
          Colors.green,
          Colors.yellow,
          Colors.red,
        ];
      case 'TD': // Chad
        return [Colors.blue, Colors.yellow, Colors.red];
      case 'KM': // Comoros
        return [
          Colors.green,
          Colors.white,
          Colors.red,
          Colors.blue,
          Colors.yellow,
        ];
      case 'CD': // DR Congo
        return [Colors.blue, Colors.yellow, Colors.red];
      case 'CG': // Republic of Congo
        return [Colors.green, Colors.yellow, Colors.red];
      case 'CI': // Côte d'Ivoire
        return [Colors.orange, Colors.white, Colors.green];
      case 'DJ': // Djibouti
        return [Colors.blue, Colors.green, Colors.white, Colors.red];
      case 'EG': // Egypt
        return [Colors.red, Colors.white, Colors.black];
      case 'GQ': // Equatorial Guinea
        return [Colors.green, Colors.white, Colors.red, Colors.blue];
      case 'ER': // Eritrea
        return [Colors.green, Colors.blue, Colors.red];
      case 'SZ': // Eswatini
        return [
          Colors.blue,
          Colors.yellow,
          Colors.red,
          Colors.black,
          Colors.white,
        ];
      case 'ET': // Ethiopia
        return [Colors.green, Colors.yellow, Colors.red, Colors.blue];
      case 'GA': // Gabon
        return [Colors.green, Colors.yellow, Colors.blue];
      case 'GM': // Gambia
        return [Colors.red, Colors.blue, Colors.green, Colors.white];
      case 'GH': // Ghana
        return [Colors.red, Colors.yellow, Colors.green, Colors.black];
      case 'GN': // Guinea
        return [Colors.red, Colors.yellow, Colors.green];
      case 'GW': // Guinea-Bissau
        return [Colors.red, Colors.yellow, Colors.green, Colors.black];
      case 'KE': // Kenya
        return [Colors.black, Colors.red, Colors.green, Colors.white];
      case 'LS': // Lesotho
        return [Colors.blue, Colors.white, Colors.green, Colors.black];
      case 'LR': // Liberia
        return [Colors.red, Colors.white, Colors.blue];
      case 'LY': // Libya
        return [Colors.red, Colors.black, Colors.green, Colors.white];
      case 'MG': // Madagascar
        return [Colors.white, Colors.red, Colors.green];
      case 'MW': // Malawi
        return [Colors.black, Colors.red, Colors.green];
      case 'ML': // Mali
        return [Colors.green, Colors.yellow, Colors.red];
      case 'MR': // Mauritania
        return [Colors.green, Colors.yellow, Colors.red];
      case 'MU': // Mauritius
        return [Colors.red, Colors.blue, Colors.yellow, Colors.green];
      case 'MA': // Morocco
        return [Colors.red, Colors.green];
      case 'MZ': // Mozambique
        return [
          Colors.green,
          Colors.black,
          Colors.yellow,
          Colors.white,
          Colors.red,
        ];
      case 'NA': // Namibia
        return [
          Colors.blue,
          Colors.white,
          Colors.green,
          Colors.red,
          Colors.blue,
        ];
      case 'NE': // Niger
        return [Colors.orange, Colors.white, Colors.green];
      case 'NG': // Nigeria
        return [Colors.green, Colors.white, Colors.green];
      case 'RW': // Rwanda
        return [Colors.blue, Colors.yellow, Colors.green];
      case 'ST': // São Tomé and Príncipe
        return [Colors.green, Colors.yellow, Colors.red, Colors.black];
      case 'SN': // Senegal
        return [Colors.green, Colors.yellow, Colors.red];
      case 'SC': // Seychelles
        return [
          Colors.blue,
          Colors.yellow,
          Colors.red,
          Colors.white,
          Colors.green,
        ];
      case 'SL': // Sierra Leone
        return [Colors.green, Colors.white, Colors.blue];
      case 'SO': // Somalia
        return [Colors.blue, Colors.white];
      case 'ZA': // South Africa
        return [
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.black,
          Colors.white,
          Colors.yellow,
        ];
      case 'SS': // South Sudan
        return [
          Colors.black,
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
        ];
      case 'SD': // Sudan
        return [Colors.red, Colors.white, Colors.black, Colors.green];
      case 'TZ': // Tanzania
        return [Colors.green, Colors.yellow, Colors.blue, Colors.black];
      case 'TG': // Togo
        return [Colors.green, Colors.yellow, Colors.red];
      case 'TN': // Tunisia
        return [Colors.red, Colors.white];
      case 'UG': // Uganda
        return [Colors.black, Colors.yellow, Colors.red, Colors.white];
      case 'ZM': // Zambia
        return [Colors.green, Colors.red, Colors.black, Colors.orange];
      case 'ZW': // Zimbabwe
        return [
          Colors.green,
          Colors.yellow,
          Colors.red,
          Colors.black,
          Colors.white,
        ];

      // ========== ASIA (48 COUNTRIES) ==========
      case 'AF': // Afghanistan
        return [Colors.black, Colors.red, Colors.green];
      case 'AM': // Armenia
        return [Colors.red, Colors.blue, Colors.orange];
      case 'AZ': // Azerbaijan
        return [Colors.blue, Colors.red, Colors.green];
      case 'BH': // Bahrain
        return [Colors.red, Colors.white];
      case 'BD': // Bangladesh
        return [Colors.green, Colors.red];
      case 'BT': // Bhutan
        return [Colors.yellow, Colors.orange];
      case 'BN': // Brunei
        return [Colors.yellow, Colors.white, Colors.black];
      case 'KH': // Cambodia
        return [Colors.blue, Colors.red];
      case 'CN': // China
        return [Colors.red, Colors.yellow];
      case 'CY': // Cyprus
        return [Colors.white, Colors.yellow, Colors.green];
      case 'GE': // Georgia
        return [Colors.white, Colors.red];
      case 'IN': // India
        return [Colors.orange, Colors.white, Colors.green, Colors.blue];
      case 'ID': // Indonesia
        return [Colors.red, Colors.white];
      case 'IR': // Iran
        return [Colors.green, Colors.white, Colors.red];
      case 'IQ': // Iraq
        return [Colors.red, Colors.white, Colors.black, Colors.green];
      case 'IL': // Israel
        return [Colors.white, Colors.blue];
      case 'JP': // Japan
        return [Colors.white, Colors.red];
      case 'JO': // Jordan
        return [Colors.black, Colors.white, Colors.green, Colors.red];
      case 'KZ': // Kazakhstan
        return [Colors.blue, Colors.yellow];
      case 'KW': // Kuwait
        return [Colors.green, Colors.white, Colors.red, Colors.black];
      case 'KG': // Kyrgyzstan
        return [Colors.red, Colors.yellow];
      case 'LA': // Laos
        return [Colors.red, Colors.blue, Colors.white];
      case 'LB': // Lebanon
        return [Colors.red, Colors.white, Colors.green];
      case 'MY': // Malaysia
        return [Colors.red, Colors.white, Colors.blue, Colors.yellow];
      case 'MV': // Maldives
        return [Colors.red, Colors.green, Colors.white];
      case 'MN': // Mongolia
        return [Colors.red, Colors.blue, Colors.red];
      case 'MM': // Myanmar
        return [Colors.yellow, Colors.green, Colors.red, Colors.white];
      case 'NP': // Nepal
        return [Colors.red, Colors.blue, Colors.white];
      case 'KP': // North Korea
        return [Colors.blue, Colors.white, Colors.red];
      case 'OM': // Oman
        return [Colors.red, Colors.white, Colors.green];
      case 'PK': // Pakistan
        return [Colors.green, Colors.white];
      case 'PH': // Philippines
        return [Colors.blue, Colors.red, Colors.white, Colors.yellow];
      case 'QA': // Qatar
        return [Colors.brown, Colors.white];
      case 'SA': // Saudi Arabia
        return [Colors.green, Colors.white];
      case 'SG': // Singapore
        return [Colors.red, Colors.white];
      case 'KR': // South Korea
        return [Colors.white, Colors.black, Colors.red, Colors.blue];
      case 'LK': // Sri Lanka
        return [Colors.yellow, Colors.orange, Colors.green, Colors.brown];
      case 'SY': // Syria
        return [Colors.red, Colors.white, Colors.black, Colors.green];
      case 'TW': // Taiwan
        return [Colors.red, Colors.blue, Colors.white];
      case 'TJ': // Tajikistan
        return [Colors.red, Colors.white, Colors.green];
      case 'TH': // Thailand
        return [Colors.red, Colors.white, Colors.blue];
      case 'TL': // Timor-Leste
        return [Colors.red, Colors.black, Colors.yellow, Colors.white];
      case 'TR': // Turkey
        return [Colors.red, Colors.white];
      case 'TM': // Turkmenistan
        return [Colors.green, Colors.white, Colors.red, Colors.yellow];
      case 'AE': // UAE
        return [Colors.red, Colors.green, Colors.white, Colors.black];
      case 'UZ': // Uzbekistan
        return [Colors.blue, Colors.white, Colors.green, Colors.red];
      case 'VN': // Vietnam
        return [Colors.red, Colors.yellow];
      case 'YE': // Yemen
        return [Colors.red, Colors.white, Colors.black];

      // ========== EUROPE (44 COUNTRIES) ==========
      case 'AL': // Albania
        return [Colors.red, Colors.black];
      case 'AD': // Andorra
        return [Colors.blue, Colors.yellow, Colors.red];
      case 'AT': // Austria
        return [Colors.red, Colors.white, Colors.red];
      case 'BY': // Belarus
        return [Colors.red, Colors.green, Colors.white];
      case 'BE': // Belgium
        return [Colors.black, Colors.yellow, Colors.red];
      case 'BA': // Bosnia and Herzegovina
        return [Colors.blue, Colors.yellow, Colors.white];
      case 'BG': // Bulgaria
        return [Colors.white, Colors.green, Colors.red];
      case 'HR': // Croatia
        return [Colors.red, Colors.white, Colors.blue];
      case 'CZ': // Czech Republic
        return [Colors.white, Colors.red, Colors.blue];
      case 'DK': // Denmark
        return [Colors.red, Colors.white];
      case 'EE': // Estonia
        return [Colors.blue, Colors.black, Colors.white];
      case 'FI': // Finland
        return [Colors.white, Colors.blue];
      case 'FR': // France
        return [Colors.blue, Colors.white, Colors.red];
      case 'DE': // Germany
        return [Colors.black, Colors.red, Colors.yellow];
      case 'GR': // Greece
        return [Colors.blue, Colors.white];
      case 'HU': // Hungary
        return [Colors.red, Colors.white, Colors.green];
      case 'IS': // Iceland
        return [Colors.blue, Colors.white, Colors.red];
      case 'IE': // Ireland
        return [Colors.green, Colors.white, Colors.orange];
      case 'IT': // Italy
        return [Colors.green, Colors.white, Colors.red];
      case 'LV': // Latvia
        return [Colors.red, Colors.white, Colors.red];
      case 'LI': // Liechtenstein
        return [Colors.blue, Colors.red];
      case 'LT': // Lithuania
        return [Colors.yellow, Colors.green, Colors.red];
      case 'LU': // Luxembourg
        return [Colors.red, Colors.white, Colors.blue];
      case 'MT': // Malta
        return [Colors.white, Colors.red];
      case 'MD': // Moldova
        return [Colors.blue, Colors.yellow, Colors.red];
      case 'MC': // Monaco
        return [Colors.red, Colors.white];
      case 'ME': // Montenegro
        return [Colors.red, Colors.yellow];
      case 'NL': // Netherlands
        return [Colors.red, Colors.white, Colors.blue];
      case 'MK': // North Macedonia
        return [Colors.red, Colors.yellow];
      case 'NO': // Norway
        return [Colors.red, Colors.white, Colors.blue];
      case 'PL': // Poland
        return [Colors.white, Colors.red];
      case 'PT': // Portugal
        return [Colors.green, Colors.red];
      case 'RO': // Romania
        return [Colors.blue, Colors.yellow, Colors.red];
      case 'RU': // Russia
        return [Colors.white, Colors.blue, Colors.red];
      case 'SM': // San Marino
        return [Colors.white, Colors.blue];
      case 'RS': // Serbia
        return [Colors.red, Colors.blue, Colors.white];
      case 'SK': // Slovakia
        return [Colors.white, Colors.blue, Colors.red];
      case 'SI': // Slovenia
        return [Colors.white, Colors.blue, Colors.red];
      case 'ES': // Spain
        return [Colors.red, Colors.yellow, Colors.red];
      case 'SE': // Sweden
        return [Colors.blue, Colors.yellow];
      case 'CH': // Switzerland
        return [Colors.red, Colors.white];
      case 'UA': // Ukraine
        return [Colors.blue, Colors.yellow];
      case 'GB': // United Kingdom
        return [Colors.blue, Colors.white, Colors.red];
      case 'VA': // Vatican City
        return [Colors.yellow, Colors.white];

      // ========== NORTH AMERICA (23 COUNTRIES) ==========
      case 'AG': // Antigua and Barbuda
        return [
          Colors.black,
          Colors.blue,
          Colors.white,
          Colors.red,
          Colors.yellow,
        ];
      case 'BS': // Bahamas
        return [Colors.cyanAccent, Colors.yellow, Colors.cyanAccent];
      case 'BB': // Barbados
        return [Colors.blue, Colors.yellow, Colors.blue];
      case 'BZ': // Belize
        return [Colors.blue, Colors.red, Colors.white];
      case 'CA': // Canada
        return [Colors.red, Colors.white, Colors.red];
      case 'CR': // Costa Rica
        return [Colors.blue, Colors.white, Colors.red];
      case 'CU': // Cuba
        return [Colors.blue, Colors.white, Colors.red];
      case 'DM': // Dominica
        return [
          Colors.green,
          Colors.yellow,
          Colors.black,
          Colors.white,
          Colors.red,
        ];
      case 'DO': // Dominican Republic
        return [Colors.blue, Colors.white, Colors.red];
      case 'SV': // El Salvador
        return [Colors.blue, Colors.white, Colors.blue];
      case 'GD': // Grenada
        return [Colors.red, Colors.yellow, Colors.green];
      case 'GT': // Guatemala
        return [Colors.blue, Colors.white, Colors.blue];
      case 'HT': // Haiti
        return [Colors.blue, Colors.red];
      case 'HN': // Honduras
        return [Colors.blue, Colors.white, Colors.blue];
      case 'JM': // Jamaica
        return [Colors.green, Colors.yellow, Colors.black];
      case 'MX': // Mexico
        return [Colors.green, Colors.white, Colors.red];
      case 'NI': // Nicaragua
        return [Colors.blue, Colors.white, Colors.blue];
      case 'PA': // Panama
        return [Colors.white, Colors.red, Colors.blue];
      case 'KN': // Saint Kitts and Nevis
        return [
          Colors.green,
          Colors.yellow,
          Colors.black,
          Colors.red,
          Colors.white,
        ];
      case 'LC': // Saint Lucia
        return [Colors.blue, Colors.white, Colors.black, Colors.yellow];
      case 'VC': // Saint Vincent and the Grenadines
        return [Colors.blue, Colors.yellow, Colors.green];
      case 'TT': // Trinidad and Tobago
        return [Colors.red, Colors.white, Colors.black];
      case 'US': // United States
        return [Colors.red, Colors.white, Colors.blue];

      // ========== SOUTH AMERICA (12 COUNTRIES) ==========
      case 'AR': // Argentina
        return [Colors.blue, Colors.white, Colors.blue];
      case 'BO': // Bolivia
        return [Colors.red, Colors.yellow, Colors.green];
      case 'BR': // Brazil
        return [Colors.green, Colors.yellow, Colors.blue];
      case 'CL': // Chile
        return [Colors.blue, Colors.white, Colors.red];
      case 'CO': // Colombia
        return [Colors.yellow, Colors.blue, Colors.red];
      case 'EC': // Ecuador
        return [Colors.yellow, Colors.blue, Colors.red];
      case 'GY': // Guyana
        return [
          Colors.green,
          Colors.white,
          Colors.yellow,
          Colors.black,
          Colors.red,
        ];
      case 'PY': // Paraguay
        return [Colors.red, Colors.white, Colors.blue];
      case 'PE': // Peru
        return [Colors.red, Colors.white, Colors.red];
      case 'SR': // Suriname
        return [Colors.green, Colors.white, Colors.red, Colors.yellow];
      case 'UY': // Uruguay
        return [Colors.blue, Colors.white, Colors.blue];
      case 'VE': // Venezuela
        return [Colors.yellow, Colors.blue, Colors.red];

      // ========== OCEANIA (14 COUNTRIES) ==========
      case 'AU': // Australia
        return [Colors.blue, Colors.white, Colors.red];
      case 'FJ': // Fiji
        return [Colors.blue, Colors.white, Colors.red];
      case 'KI': // Kiribati
        return [Colors.red, Colors.blue, Colors.white, Colors.yellow];
      case 'MH': // Marshall Islands
        return [Colors.blue, Colors.white, Colors.orange];
      case 'FM': // Micronesia
        return [Colors.blue, Colors.white];
      case 'NR': // Nauru
        return [Colors.blue, Colors.yellow, Colors.white];
      case 'NZ': // New Zealand
        return [Colors.blue, Colors.red, Colors.white];
      case 'PW': // Palau
        return [Colors.blue, Colors.yellow];
      case 'PG': // Papua New Guinea
        return [Colors.red, Colors.black, Colors.yellow, Colors.white];
      case 'WS': // Samoa
        return [Colors.red, Colors.blue, Colors.white];
      case 'SB': // Solomon Islands
        return [Colors.blue, Colors.yellow, Colors.green, Colors.white];
      case 'TO': // Tonga
        return [Colors.red, Colors.white];
      case 'TV': // Tuvalu
        return [Colors.blue, Colors.yellow, Colors.white];
      case 'VU': // Vanuatu
        return [Colors.red, Colors.black, Colors.green, Colors.yellow];

      // ========== SPECIAL CASES ==========
      case 'EU': // European Union
        return [Colors.blue, Colors.yellow];
      case 'UN': // United Nations
        return [Colors.blue, Colors.white];
      case 'IO': // British Indian Ocean Territory
        return [Colors.blue, Colors.white, Colors.blue];
      case 'XK': // Kosovo (disputed)
        return [Colors.blue, Colors.white, Colors.yellow];
      case 'PS': // Palestine
        return [Colors.black, Colors.white, Colors.green, Colors.red];

      // Default for unknown/incorrect codes
      default:
        return [Colors.blue, Colors.white, Colors.red];
    }
  }

  static String getDepartureGreeting(String languageCode, String countryName) {
    final greeting = _getGoodbyeInLanguage(languageCode);
    return '$greeting $countryName';
  }

  static String getArrivalGreeting(String languageCode, String countryName) {
    final eager = _getEagerToSeeYouInLanguage(languageCode);
    final welcome = _getWelcomeInLanguage(languageCode);
    final preposition = _getWelcomePrepositionInLanguage(languageCode);

    // Ensure accurate spacing
    final prepString = preposition.isNotEmpty ? ' $preposition' : '';

    return '$eager, $welcome$prepString $countryName';
  }

  static String _getEagerToSeeYouInLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'fr':
        return 'Nous sommes impatients de vous voir';
      case 'es':
        return 'Estamos ansiosos por verte';
      case 'de':
        return 'Wir freuen uns darauf, dich zu sehen';
      case 'it':
        return 'Non vediamo l\'ora di vederti';
      case 'pt':
        return 'Estamos ansiosos para ver você';
      case 'nl':
        return 'We kijken ernaar uit je te zien';
      case 'ru':
        return 'Мы с нетерпением ждем встречи с вами';
      case 'zh':
        return '我们迫不及待地想见到你';
      case 'ja':
        return 'お会いできるのを楽しみにしています';
      case 'ko':
        return '만나서 반가워요';
      case 'ar':
        return 'نحن متشوقون لرؤيتك';
      case 'hi':
        return 'हम आपको देखने के लिए उत्सुक हैं';
      case 'bn':
        return 'আমরা আপনাকে দেখার জন্য উন্মুখ';
      case 'tr':
        return 'Sizi görmeyi dört gözle bekliyoruz';
      case 'sw':
        return 'Tunatamani kukuona';
      case 'am':
        return 'እርስዎን ለማየት ጓጉተናል'; // Amharic
      default:
        return 'We are eager to see you';
    }
  }

  static String _getWelcomePrepositionInLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'en':
        return 'to';
      case 'fr':
        return 'en'; // Usage varies (en/au/aux) but 'en' is a safe generic for countries
      case 'es':
        return 'a';
      case 'pt':
        return 'ao'; // or 'a', 'em'
      case 'it':
        return 'in'; // or 'a'
      case 'de':
        return 'in'; // or 'nach'
      case 'nl':
        return 'in';
      case 'ar':
        return 'في'; // fi
      case 'sw':
        return ''; // User requested removal of 'katika'
      case 'ru':
        return 'в';
      case 'tr':
        return ''; // Suffix based, tough to map accurately with simple string join
      case 'zh':
        return ''; // Usually implied or different structure
      case 'ja':
        return 'へ'; // he (towards)
      default:
        return 'to';
    }
  }

  // ========== COMPLETE LANGUAGE SUPPORT (100+ LANGUAGES) ==========
  static String _getGoodbyeInLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      // Official UN languages
      case 'en':
        return 'Goodbye'; // English
      case 'fr':
        return 'Au revoir'; // French
      case 'es':
        return 'Adiós'; // Spanish
      case 'ru':
        return 'До свидания'; // Russian
      case 'zh':
        return '再见'; // Chinese (Simplified)
      case 'ar':
        return 'وداعاً'; // Arabic

      // European languages
      case 'de':
        return 'Auf Wiedersehen'; // German
      case 'it':
        return 'Arrivederci'; // Italian
      case 'pt':
        return 'Adeus'; // Portuguese
      case 'nl':
        return 'Tot ziens'; // Dutch
      case 'el':
        return 'Αντίο'; // Greek
      case 'pl':
        return 'Do widzenia'; // Polish
      case 'uk':
        return 'До побачення'; // Ukrainian
      case 'cs':
        return 'Sbohem'; // Czech
      case 'ro':
        return 'La revedere'; // Romanian
      case 'hu':
        return 'Viszlát'; // Hungarian
      case 'sv':
        return 'Adjö'; // Swedish
      case 'da':
        return 'Farvel'; // Danish
      case 'fi':
        return 'Näkemiin'; // Finnish
      case 'no':
        return 'Farvel'; // Norwegian
      case 'sk':
        return 'Dovidenia'; // Slovak
      case 'sl':
        return 'Nasvidenje'; // Slovenian
      case 'hr':
        return 'Doviđenja'; // Croatian
      case 'sr':
        return 'Довиђења'; // Serbian
      case 'bg':
        return 'Довиждане'; // Bulgarian
      case 'lt':
        return 'Viso gero'; // Lithuanian
      case 'lv':
        return 'Ardievu'; // Latvian
      case 'et':
        return 'Hüvasti'; // Estonian
      case 'mt':
        return 'Addiju'; // Maltese
      case 'ga':
        return 'Slán'; // Irish
      case 'cy':
        return 'Hwyl fawr'; // Welsh
      case 'eu':
        return 'Agur'; // Basque
      case 'ca':
        return 'Adéu'; // Catalan

      // Asian languages
      case 'hi':
        return 'अलविदा'; // Hindi
      case 'bn':
        return 'বিদায়'; // Bengali
      case 'pa':
        return 'ਅਲਵਿਦਾ'; // Punjabi
      case 'ur':
        return 'الوداع'; // Urdu
      case 'fa':
        return 'خداحافظ'; // Persian
      case 'tr':
        return 'Güle güle'; // Turkish
      case 'th':
        return 'ลาก่อน'; // Thai
      case 'vi':
        return 'Tạm biệt'; // Vietnamese
      case 'ko':
        return '안녕히 가세요'; // Korean
      case 'ja':
        return 'さようなら'; // Japanese
      case 'km':
        return 'លា'; // Khmer
      case 'lo':
        return 'ລາກ່ອນ'; // Lao
      case 'my':
        return 'သွားတော့မယ်'; // Burmese
      case 'ne':
        return 'अलविदा'; // Nepali
      case 'si':
        return 'ආයුබෝවන්'; // Sinhala
      case 'ta':
        return 'பிரியாவிடை'; // Tamil
      case 'te':
        return 'వీడ్కోలు'; // Telugu
      case 'ml':
        return 'വിട'; // Malayalam
      case 'kn':
        return 'ವಿದಾಯ'; // Kannada
      case 'gu':
        return 'આવજો'; // Gujarati
      case 'mr':
        return 'अलविदा'; // Marathi
      case 'or':
        return 'ବିଦାୟ'; // Odia
      case 'as':
        return 'বিদায়'; // Assamese
      case 'sd':
        return 'خدا حافظ'; // Sindhi

      // African languages
      case 'sw':
        return 'Kwaheri'; // Swahili
      case 'ha':
        return 'Sai wata rana'; // Hausa
      case 'yo':
        return 'O dabọ'; // Yoruba
      case 'ig':
        return 'Ka ọ dị'; // Igbo
      case 'am':
        return 'ቻው'; // Amharic
      case 'so':
        return 'Nabad gelyo'; // Somali
      case 'zu':
        return 'Hamba kahle'; // Zulu
      case 'xh':
        return 'Usale kakuhle'; // Xhosa
      case 'rw':
        return 'Murabeho'; // Kinyarwanda
      case 'sn':
        return 'Sara zvakanaka'; // Shona
      case 'mg':
        return 'Veloma'; // Malagasy
      case 'st':
        return 'Sala hantle'; // Southern Sotho
      case 'tn':
        return 'Tsamaya sentle'; // Tswana
      case 'ss':
        return 'Sala kahle'; // Swati
      case 've':
        return 'Kha vha sale'; // Venda
      case 'ts':
        return 'Sala hantle'; // Tsonga
      case 'ny':
        return 'Pitani bwino'; // Chichewa
      case 'ff':
        return 'Jaay e jam'; // Fula
      case 'kr':
        return 'Ya kunto'; // Kanuri
      case 'sg':
        return 'Balaô'; // Sango

      // Middle Eastern languages
      case 'he':
        return 'להתראות'; // Hebrew
      case 'ps':
        return 'په خیر'; // Pashto
      case 'ku':
        return 'خوا حافظ'; // Kurdish
      case 'arc':
        return 'ܫܠܡܐ'; // Aramaic

      // Indigenous & Regional languages
      case 'haw':
        return 'Aloha'; // Hawaiian
      case 'mi':
        return 'Hei konā'; // Maori
      case 'sm':
        return 'Tofa'; // Samoan
      case 'fj':
        return 'Moce'; // Fijian
      case 'to':
        return 'ʻAlu ā'; // Tongan
      case 'ty':
        return 'Nana'; // Tahitian
      case 'kl':
        return 'Ajornarmik'; // Greenlandic
      case 'iu':
        return 'ᐃᓪᓗᕆᐊᖅᑎᑦᑎᔾᔪᑎ'; // Inuktitut
      case 'cr':
        return 'ᑕᐃᔭᐅᒋᐊᕐᓂᖅ'; // Cree
      case 'oj':
        return 'Giga-waabamin'; // Ojibwe
      case 'nv':
        return 'Hágoóneeʼ'; // Navajo
      case 'qu':
        return 'Tupananchiskama'; // Quechua
      case 'ay':
        return 'Jaytam'; // Aymara
      case 'gn':
        return 'Jajotopata'; // Guarani

      // Constructed languages
      case 'eo':
        return 'Ĝis revido'; // Esperanto
      case 'vo':
        return 'Löfölö'; // Volapük

      default:
        // Try to find a close match (e.g., zh-CN, zh-TW)
        if (languageCode.toLowerCase().startsWith('zh')) return '再见';
        if (languageCode.toLowerCase().startsWith('pt')) return 'Adeus';
        if (languageCode.toLowerCase().startsWith('ar')) return 'وداعاً';
        return 'Goodbye';
    }
  }

  static String _getWelcomeInLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      // Official UN languages
      case 'en':
        return 'Welcome'; // English
      case 'fr':
        return 'Bienvenue'; // French
      case 'es':
        return 'Bienvenido'; // Spanish
      case 'ru':
        return 'Добро пожаловать'; // Russian
      case 'zh':
        return '欢迎'; // Chinese (Simplified)
      case 'ar':
        return 'مرحباً'; // Arabic

      // European languages
      case 'de':
        return 'Willkommen'; // German
      case 'it':
        return 'Benvenuto'; // Italian
      case 'pt':
        return 'Bem-vindo'; // Portuguese
      case 'nl':
        return 'Welkom'; // Dutch
      case 'el':
        return 'Καλώς ορίσατε'; // Greek
      case 'pl':
        return 'Witamy'; // Polish
      case 'uk':
        return 'Ласкаво просимо'; // Ukrainian
      case 'cs':
        return 'Vítejte'; // Czech
      case 'ro':
        return 'Bine ati venit'; // Romanian
      case 'hu':
        return 'Üdvözöljük'; // Hungarian
      case 'sv':
        return 'Välkommen'; // Swedish
      case 'da':
        return 'Velkommen'; // Danish
      case 'fi':
        return 'Tervetuloa'; // Finnish
      case 'no':
        return 'Velkommen'; // Norwegian
      case 'sk':
        return 'Vitajte'; // Slovak
      case 'sl':
        return 'Dobrodošli'; // Slovenian
      case 'hr':
        return 'Dobrodošli'; // Croatian
      case 'sr':
        return 'Добродошли'; // Serbian
      case 'bg':
        return 'Добре дошли'; // Bulgarian
      case 'lt':
        return 'Sveiki atvykę'; // Lithuanian
      case 'lv':
        return 'Laipni lūdzam'; // Latvian
      case 'et':
        return 'Tere tulemast'; // Estonian
      case 'mt':
        return 'Merħba'; // Maltese
      case 'ga':
        return 'Fáilte'; // Irish
      case 'cy':
        return 'Croeso'; // Welsh
      case 'eu':
        return 'Ongi etorri'; // Basque
      case 'ca':
        return 'Benvingut'; // Catalan

      // Asian languages
      case 'hi':
        return 'स्वागत है'; // Hindi
      case 'bn':
        return 'স্বাগতম'; // Bengali
      case 'pa':
        return 'ਜੀ ਆਇਆਂ ਨੂੰ'; // Punjabi
      case 'ur':
        return 'خوش آمدید'; // Urdu
      case 'fa':
        return 'خوش آمدید'; // Persian
      case 'tr':
        return 'Hoş geldiniz'; // Turkish
      case 'th':
        return 'ยินดีต้อนรับ'; // Thai
      case 'vi':
        return 'Chào mừng'; // Vietnamese
      case 'ko':
        return '환영합니다'; // Korean
      case 'ja':
        return 'ようこそ'; // Japanese
      case 'km':
        return 'សូមស្វាគមន៍'; // Khmer
      case 'lo':
        return 'ຍິນດີຕ້ອນຮັບ'; // Lao
      case 'my':
        return 'ကြိုဆိုပါတယ်'; // Burmese
      case 'ne':
        return 'स्वागतम्'; // Nepali
      case 'si':
        return 'ආයුබෝවන්'; // Sinhala
      case 'ta':
        return 'வரவேற்பு'; // Tamil
      case 'te':
        return 'స్వాగతం'; // Telugu
      case 'ml':
        return 'സ്വാഗതം'; // Malayalam
      case 'kn':
        return 'ಸ್ವಾಗತ'; // Kannada
      case 'gu':
        return 'સ્વાગત છે'; // Gujarati
      case 'mr':
        return 'स्वागत आहे'; // Marathi
      case 'or':
        return 'ସ୍ୱାଗତ'; // Odia
      case 'as':
        return 'স্বাগতম'; // Assamese
      case 'sd':
        return 'خوشآمديد'; // Sindhi

      // African languages
      case 'sw':
        return 'Karibu'; // Swahili
      case 'ha':
        return 'Barka da zuwa'; // Hausa
      case 'yo':
        return 'Káàbọ̀'; // Yoruba
      case 'ig':
        return 'Nnọọ'; // Igbo
      case 'am':
        return 'እንኳን ደህና መጡ'; // Amharic
      case 'so':
        return 'Soo dhawoow'; // Somali
      case 'zu':
        return 'Siyakwamukela'; // Zulu
      case 'xh':
        return 'Wamkelekile'; // Xhosa
      case 'rw':
        return 'Murakaza neza'; // Kinyarwanda
      case 'sn':
        return 'Tigashire'; // Shona
      case 'mg':
        return 'Tongasoa'; // Malagasy
      case 'st':
        return 'Re a leboha'; // Southern Sotho
      case 'tn':
        return 'O amogetswe'; // Tswana
      case 'ss':
        return 'Ngiyakwemukela'; // Swati
      case 've':
        return 'Ndi a livhuwa'; // Venda
      case 'ts':
        return 'Ndzi amukela'; // Tsonga
      case 'ny':
        return 'Takulandirani'; // Chichewa
      case 'ff':
        return 'Miɗo'; // Fula
      case 'kr':
        return 'Gamsude'; // Kanuri
      case 'sg':
        return 'Balaô'; // Sango

      // Middle Eastern languages
      case 'he':
        return 'ברוך הבא'; // Hebrew
      case 'ps':
        return 'ښه راغلاست'; // Pashto
      case 'ku':
        return 'Bi xêr hatî'; // Kurdish
      case 'arc':
        return 'ܒܪܝܟܐ ܐܬܐ'; // Aramaic

      // Indigenous & Regional languages
      case 'haw':
        return 'Aloha'; // Hawaiian
      case 'mi':
        return 'Nau mai'; // Maori
      case 'sm':
        return 'Afio mai'; // Samoan
      case 'fj':
        return 'Bula'; // Fijian
      case 'to':
        return 'Mālō e lelei'; // Tongan
      case 'ty':
        return 'Maeva'; // Tahitian
      case 'kl':
        return 'Tikilluarit'; // Greenlandic
      case 'iu':
        return 'ᐊᓂᒪᕆᐅᖅᑕᐅᓯᒪᔪᖅ'; // Inuktitut
      case 'cr':
        return 'ᐊᐃᑦᑖᕆᐊᖅᑎᑦᑎᔪᖅ'; // Cree
      case 'oj':
        return 'Biindigen'; // Ojibwe
      case 'nv':
        return 'Yáʼátʼééh'; // Navajo
      case 'qu':
        return 'Allinllachu'; // Quechua
      case 'ay':
        return 'Aski urukipan'; // Aymara
      case 'gn':
        return 'Aguyje'; // Guarani

      // Constructed languages
      case 'eo':
        return 'Bonvenon'; // Esperanto
      case 'vo':
        return 'Välkom'; // Volapük

      default:
        // Try to find a close match
        if (languageCode.toLowerCase().startsWith('zh')) return '欢迎';
        if (languageCode.toLowerCase().startsWith('pt')) return 'Bem-vindo';
        if (languageCode.toLowerCase().startsWith('ar')) return 'مرحباً';
        return 'Welcome';
    }
  }

  // ========== COMPLETE COUNTRY NAME DATABASE ==========
  static String getCountryName(String countryCode, String languageCode) {
    final Map<String, Map<String, String>> countryNames = {
      'AF': {'en': 'Afghanistan', 'fa': 'افغانستان', 'ps': 'افغانستان'},
      'AL': {'en': 'Albania', 'sq': 'Shqipëria'},
      'DZ': {'en': 'Algeria', 'ar': 'الجزائر'},
      'AD': {'en': 'Andorra', 'ca': 'Andorra'},
      'AO': {'en': 'Angola', 'pt': 'Angola'},
      'AG': {'en': 'Antigua and Barbuda'},
      'AR': {'en': 'Argentina', 'es': 'Argentina'},
      'AM': {'en': 'Armenia', 'hy': 'Հայաստան'},
      'AU': {'en': 'Australia'},
      'AT': {'en': 'Austria', 'de': 'Österreich'},
      'AZ': {'en': 'Azerbaijan', 'az': 'Azərbaycan'},
      'BS': {'en': 'Bahamas'},
      'BH': {'en': 'Bahrain', 'ar': 'البحرين'},
      'BD': {'en': 'Bangladesh', 'bn': 'বাংলাদেশ'},
      'BB': {'en': 'Barbados'},
      'BY': {'en': 'Belarus', 'be': 'Беларусь'},
      'BE': {'en': 'Belgium', 'nl': 'België', 'fr': 'Belgique'},
      'BZ': {'en': 'Belize'},
      'BJ': {'en': 'Benin', 'fr': 'Bénin'},
      'BT': {'en': 'Bhutan', 'dz': 'འབྲུག་ཡུལ་'},
      'BO': {'en': 'Bolivia', 'es': 'Bolivia'},
      'BA': {'en': 'Bosnia and Herzegovina', 'bs': 'Bosna i Hercegovina'},
      'BW': {'en': 'Botswana', 'tn': 'Botswana'},
      'BR': {'en': 'Brazil', 'pt': 'Brasil'},
      'BN': {'en': 'Brunei', 'ms': 'Brunei'},
      'BG': {'en': 'Bulgaria', 'bg': 'България'},
      'BF': {'en': 'Burkina Faso', 'fr': 'Burkina Faso'},
      'BI': {'en': 'Burundi', 'fr': 'Burundi'},
      'CV': {'en': 'Cabo Verde', 'pt': 'Cabo Verde'},
      'KH': {'en': 'Cambodia', 'km': 'កម្ពុជា'},
      'CM': {'en': 'Cameroon', 'fr': 'Cameroun'},
      'CA': {'en': 'Canada', 'fr': 'Canada'},
      'CF': {
        'en': 'Central African Republic',
        'fr': 'République centrafricaine',
      },
      'TD': {'en': 'Chad', 'fr': 'Tchad'},
      'CL': {'en': 'Chile', 'es': 'Chile'},
      'CN': {'en': 'China', 'zh': '中国'},
      'CO': {'en': 'Colombia', 'es': 'Colombia'},
      'KM': {'en': 'Comoros', 'fr': 'Comores'},
      'CG': {'en': 'Congo', 'fr': 'Congo'},
      'CD': {
        'en': 'Democratic Republic of the Congo',
        'fr': 'République démocratique du Congo',
      },
      'CR': {'en': 'Costa Rica', 'es': 'Costa Rica'},
      'CI': {'en': 'Côte d\'Ivoire', 'fr': 'Côte d\'Ivoire'},
      'HR': {'en': 'Croatia', 'hr': 'Hrvatska'},
      'CU': {'en': 'Cuba', 'es': 'Cuba'},
      'CY': {'en': 'Cyprus', 'el': 'Κύπρος', 'tr': 'Kıbrıs'},
      'CZ': {'en': 'Czech Republic', 'cs': 'Česko'},
      'DK': {'en': 'Denmark', 'da': 'Danmark'},
      'DJ': {'en': 'Djibouti', 'fr': 'Djibouti'},
      'DM': {'en': 'Dominica'},
      'DO': {'en': 'Dominican Republic', 'es': 'República Dominicana'},
      'EC': {'en': 'Ecuador', 'es': 'Ecuador'},
      'EG': {'en': 'Egypt', 'ar': 'مصر'},
      'SV': {'en': 'El Salvador', 'es': 'El Salvador'},
      'GQ': {'en': 'Equatorial Guinea', 'es': 'Guinea Ecuatorial'},
      'ER': {'en': 'Eritrea', 'ti': 'ኤርትራ'},
      'EE': {'en': 'Estonia', 'et': 'Eesti'},
      'SZ': {'en': 'Eswatini', 'en': 'Eswatini'},
      'ET': {'en': 'Ethiopia', 'am': 'ኢትዮጵያ'},
      'FJ': {'en': 'Fiji'},
      'FI': {'en': 'Finland', 'fi': 'Suomi'},
      'FR': {'en': 'France', 'fr': 'France'},
      'GA': {'en': 'Gabon', 'fr': 'Gabon'},
      'GM': {'en': 'Gambia'},
      'GE': {'en': 'Georgia', 'ka': 'საქართველო'},
      'DE': {'en': 'Germany', 'de': 'Deutschland'},
      'GH': {'en': 'Ghana'},
      'GR': {'en': 'Greece', 'el': 'Ελλάδα'},
      'GD': {'en': 'Grenada'},
      'GT': {'en': 'Guatemala', 'es': 'Guatemala'},
      'GN': {'en': 'Guinea', 'fr': 'Guinée'},
      'GW': {'en': 'Guinea-Bissau', 'pt': 'Guiné-Bissau'},
      'GY': {'en': 'Guyana'},
      'HT': {'en': 'Haiti', 'fr': 'Haïti'},
      'HN': {'en': 'Honduras', 'es': 'Honduras'},
      'HU': {'en': 'Hungary', 'hu': 'Magyarország'},
      'IS': {'en': 'Iceland', 'is': 'Ísland'},
      'IN': {'en': 'India', 'hi': 'भारत'},
      'ID': {'en': 'Indonesia', 'id': 'Indonesia'},
      'IR': {'en': 'Iran', 'fa': 'ایران'},
      'IQ': {'en': 'Iraq', 'ar': 'العراق'},
      'IE': {'en': 'Ireland', 'ga': 'Éire'},
      'IL': {'en': 'Israel', 'he': 'ישראל'},
      'IT': {'en': 'Italy', 'it': 'Italia'},
      'JM': {'en': 'Jamaica'},
      'JP': {'en': 'Japan', 'ja': '日本'},
      'JO': {'en': 'Jordan', 'ar': 'الأردن'},
      'KZ': {'en': 'Kazakhstan', 'kk': 'Қазақстан'},
      'KE': {'en': 'Kenya', 'sw': 'Kenya'},
      'KI': {'en': 'Kiribati'},
      'KP': {'en': 'North Korea', 'ko': '조선민주주의인민공화국'},
      'KR': {'en': 'South Korea', 'ko': '대한민국'},
      'KW': {'en': 'Kuwait', 'ar': 'الكويت'},
      'KG': {'en': 'Kyrgyzstan', 'ky': 'Кыргызстан'},
      'LA': {'en': 'Laos', 'lo': 'ລາວ'},
      'LV': {'en': 'Latvia', 'lv': 'Latvija'},
      'LB': {'en': 'Lebanon', 'ar': 'لبنان'},
      'LS': {'en': 'Lesotho', 'st': 'Lesotho'},
      'LR': {'en': 'Liberia'},
      'LY': {'en': 'Libya', 'ar': 'ليبيا'},
      'LI': {'en': 'Liechtenstein', 'de': 'Liechtenstein'},
      'LT': {'en': 'Lithuania', 'lt': 'Lietuva'},
      'LU': {'en': 'Luxembourg', 'fr': 'Luxembourg'},
      'MG': {'en': 'Madagascar', 'mg': 'Madagasikara'},
      'MW': {'en': 'Malawi', 'ny': 'Malawi'},
      'MY': {'en': 'Malaysia', 'ms': 'Malaysia'},
      'MV': {'en': 'Maldives', 'dv': 'ދިވެހިރާއްޖެ'},
      'ML': {'en': 'Mali', 'fr': 'Mali'},
      'MT': {'en': 'Malta', 'mt': 'Malta'},
      'MH': {'en': 'Marshall Islands'},
      'MR': {'en': 'Mauritania', 'ar': 'موريتانيا'},
      'MU': {'en': 'Mauritius', 'en': 'Mauritius'},
      'MX': {'en': 'Mexico', 'es': 'México'},
      'FM': {'en': 'Micronesia'},
      'MD': {'en': 'Moldova', 'ro': 'Moldova'},
      'MC': {'en': 'Monaco', 'fr': 'Monaco'},
      'MN': {'en': 'Mongolia', 'mn': 'Монгол улс'},
      'ME': {'en': 'Montenegro', 'sr': 'Црна Гора'},
      'MA': {'en': 'Morocco', 'ar': 'المغرب'},
      'MZ': {'en': 'Mozambique', 'pt': 'Moçambique'},
      'MM': {'en': 'Myanmar', 'my': 'မြန်မာ'},
      'NA': {'en': 'Namibia'},
      'NR': {'en': 'Nauru'},
      'NP': {'en': 'Nepal', 'ne': 'नेपाल'},
      'NL': {'en': 'Netherlands', 'nl': 'Nederland'},
      'NZ': {'en': 'New Zealand', 'mi': 'Aotearoa'},
      'NI': {'en': 'Nicaragua', 'es': 'Nicaragua'},
      'NE': {'en': 'Niger', 'fr': 'Niger'},
      'NG': {'en': 'Nigeria'},
      'NO': {'en': 'Norway', 'no': 'Norge'},
      'OM': {'en': 'Oman', 'ar': 'عُمان'},
      'PK': {'en': 'Pakistan', 'ur': 'پاکستان'},
      'PW': {'en': 'Palau'},
      'PS': {'en': 'Palestine', 'ar': 'فلسطين'},
      'PA': {'en': 'Panama', 'es': 'Panamá'},
      'PG': {'en': 'Papua New Guinea'},
      'PY': {'en': 'Paraguay', 'es': 'Paraguay'},
      'PE': {'en': 'Peru', 'es': 'Perú'},
      'PH': {'en': 'Philippines', 'tl': 'Pilipinas'},
      'PL': {'en': 'Poland', 'pl': 'Polska'},
      'PT': {'en': 'Portugal', 'pt': 'Portugal'},
      'QA': {'en': 'Qatar', 'ar': 'قطر'},
      'RO': {'en': 'Romania', 'ro': 'România'},
      'RU': {'en': 'Russia', 'ru': 'Россия'},
      'RW': {'en': 'Rwanda', 'rw': 'Rwanda'},
      'KN': {'en': 'Saint Kitts and Nevis'},
      'LC': {'en': 'Saint Lucia'},
      'VC': {'en': 'Saint Vincent and the Grenadines'},
      'WS': {'en': 'Samoa'},
      'SM': {'en': 'San Marino', 'it': 'San Marino'},
      'ST': {'en': 'São Tomé and Príncipe', 'pt': 'São Tomé e Príncipe'},
      'SA': {'en': 'Saudi Arabia', 'ar': 'السعودية'},
      'SN': {'en': 'Senegal', 'fr': 'Sénégal'},
      'RS': {'en': 'Serbia', 'sr': 'Србија'},
      'SC': {'en': 'Seychelles'},
      'SL': {'en': 'Sierra Leone'},
      'SG': {'en': 'Singapore', 'ms': 'Singapura'},
      'SK': {'en': 'Slovakia', 'sk': 'Slovensko'},
      'SI': {'en': 'Slovenia', 'sl': 'Slovenija'},
      'SB': {'en': 'Solomon Islands'},
      'SO': {'en': 'Somalia', 'so': 'Soomaaliya'},
      'ZA': {
        'en': 'South Africa',
        'af': 'Suid-Afrika',
        'zu': 'iNingizimu Afrika',
      },
      'SS': {'en': 'South Sudan'},
      'ES': {'en': 'Spain', 'es': 'España'},
      'LK': {'en': 'Sri Lanka', 'si': 'ශ්‍රී ලංකාව'},
      'SD': {'en': 'Sudan', 'ar': 'السودان'},
      'SR': {'en': 'Suriname', 'nl': 'Suriname'},
      'SE': {'en': 'Sweden', 'sv': 'Sverige'},
      'CH': {'en': 'Switzerland', 'de': 'Schweiz', 'fr': 'Suisse'},
      'SY': {'en': 'Syria', 'ar': 'سوريا'},
      'TW': {'en': 'Taiwan', 'zh': '台灣'},
      'TJ': {'en': 'Tajikistan', 'tg': 'Тоҷикистон'},
      'TZ': {'en': 'Tanzania', 'sw': 'Tanzania'},
      'TH': {'en': 'Thailand', 'th': 'ประเทศไทย'},
      'TL': {'en': 'Timor-Leste', 'pt': 'Timor-Leste'},
      'TG': {'en': 'Togo', 'fr': 'Togo'},
      'TO': {'en': 'Tonga'},
      'TT': {'en': 'Trinidad and Tobago'},
      'TN': {'en': 'Tunisia', 'ar': 'تونس'},
      'TR': {'en': 'Turkey', 'tr': 'Türkiye'},
      'TM': {'en': 'Turkmenistan', 'tk': 'Türkmenistan'},
      'TV': {'en': 'Tuvalu'},
      'UG': {'en': 'Uganda', 'sw': 'Uganda'},
      'UA': {'en': 'Ukraine', 'uk': 'Україна'},
      'AE': {'en': 'United Arab Emirates', 'ar': 'الإمارات العربية المتحدة'},
      'GB': {'en': 'United Kingdom', 'en': 'United Kingdom'},
      'US': {'en': 'United States', 'es': 'Estados Unidos'},
      'UY': {'en': 'Uruguay', 'es': 'Uruguay'},
      'UZ': {'en': 'Uzbekistan', 'uz': 'Oʻzbekiston'},
      'VU': {'en': 'Vanuatu'},
      'VE': {'en': 'Venezuela', 'es': 'Venezuela'},
      'VN': {'en': 'Vietnam', 'vi': 'Việt Nam'},
      'YE': {'en': 'Yemen', 'ar': 'اليمن'},
      'ZM': {'en': 'Zambia'},
      'ZW': {'en': 'Zimbabwe', 'sn': 'Zimbabwe'},
    };

    final countryData = countryNames[countryCode.toUpperCase()];
    return countryData?[languageCode.toLowerCase()] ??
        countryData?['en'] ??
        _getCountryNameFromCode(countryCode);
  }

  /// Helper to get the primary language code for a country
  static String getPrimaryLanguageCode(String countryCode) {
    const Map<String, String> countryLanguages = {
      'OM': 'ar', // Oman -> Arabic
      'DE': 'de', // Germany -> German
      'FR': 'fr', // France -> French
      'CN': 'zh', // China -> Chinese
      'JP': 'ja', // Japan -> Japanese
      'KE': 'sw', // Kenya -> Swahili
      'TZ': 'sw', // Tanzania -> Swahili
      'UG': 'sw', // Uganda -> Swahili
      'IT': 'it', // Italy -> Italian
      'ES': 'es', // Spain -> Spanish
      'BR': 'pt', // Brazil -> Portuguese
      'RU': 'ru', // Russia -> Russian
      'IN': 'hi', // India -> Hindi (simplified default)
      'SA': 'ar', // Saudi Arabia -> Arabic
      'EG': 'ar', // Egypt -> Arabic
      'AE': 'ar', // UAE -> Arabic
      'QA': 'ar', // Qatar -> Arabic
      'US': 'en', // USA -> English
      'GB': 'en', // UK -> English
    };
    return countryLanguages[countryCode.toUpperCase()] ?? 'en';
  }

  static String _getCountryNameFromCode(String countryCode) {
    // Fallback: Return a readable name based on the code
    switch (countryCode.toUpperCase()) {
      case 'AF':
        return 'Afghanistan';
      case 'AX':
        return 'Åland Islands';
      case 'AL':
        return 'Albania';
      case 'DZ':
        return 'Algeria';
      case 'AS':
        return 'American Samoa';
      case 'AD':
        return 'Andorra';
      case 'AO':
        return 'Angola';
      case 'AI':
        return 'Anguilla';
      case 'AQ':
        return 'Antarctica';
      case 'AG':
        return 'Antigua and Barbuda';
      case 'AR':
        return 'Argentina';
      case 'AM':
        return 'Armenia';
      case 'AW':
        return 'Aruba';
      case 'AU':
        return 'Australia';
      case 'AT':
        return 'Austria';
      case 'AZ':
        return 'Azerbaijan';
      case 'BS':
        return 'Bahamas';
      case 'BH':
        return 'Bahrain';
      case 'BD':
        return 'Bangladesh';
      case 'BB':
        return 'Barbados';
      case 'BY':
        return 'Belarus';
      case 'BE':
        return 'Belgium';
      case 'BZ':
        return 'Belize';
      case 'BJ':
        return 'Benin';
      case 'BM':
        return 'Bermuda';
      case 'BT':
        return 'Bhutan';
      case 'BO':
        return 'Bolivia';
      case 'BQ':
        return 'Bonaire';
      case 'BA':
        return 'Bosnia and Herzegovina';
      case 'BW':
        return 'Botswana';
      case 'BV':
        return 'Bouvet Island';
      case 'BR':
        return 'Brazil';
      case 'IO':
        return 'British Indian Ocean Territory';
      case 'BN':
        return 'Brunei Darussalam';
      case 'BG':
        return 'Bulgaria';
      case 'BF':
        return 'Burkina Faso';
      case 'BI':
        return 'Burundi';
      case 'CV':
        return 'Cabo Verde';
      case 'KH':
        return 'Cambodia';
      case 'CM':
        return 'Cameroon';
      case 'CA':
        return 'Canada';
      case 'KY':
        return 'Cayman Islands';
      case 'CF':
        return 'Central African Republic';
      case 'TD':
        return 'Chad';
      case 'CL':
        return 'Chile';
      case 'CN':
        return 'China';
      case 'CX':
        return 'Christmas Island';
      case 'CC':
        return 'Cocos (Keeling) Islands';
      case 'CO':
        return 'Colombia';
      case 'KM':
        return 'Comoros';
      case 'CG':
        return 'Congo';
      case 'CD':
        return 'Congo (Democratic Republic)';
      case 'CK':
        return 'Cook Islands';
      case 'CR':
        return 'Costa Rica';
      case 'CI':
        return 'Côte d\'Ivoire';
      case 'HR':
        return 'Croatia';
      case 'CU':
        return 'Cuba';
      case 'CW':
        return 'Curaçao';
      case 'CY':
        return 'Cyprus';
      case 'CZ':
        return 'Czech Republic';
      case 'DK':
        return 'Denmark';
      case 'DJ':
        return 'Djibouti';
      case 'DM':
        return 'Dominica';
      case 'DO':
        return 'Dominican Republic';
      case 'EC':
        return 'Ecuador';
      case 'EG':
        return 'Egypt';
      case 'SV':
        return 'El Salvador';
      case 'GQ':
        return 'Equatorial Guinea';
      case 'ER':
        return 'Eritrea';
      case 'EE':
        return 'Estonia';
      case 'ET':
        return 'Ethiopia';
      case 'FK':
        return 'Falkland Islands';
      case 'FO':
        return 'Faroe Islands';
      case 'FJ':
        return 'Fiji';
      case 'FI':
        return 'Finland';
      case 'FR':
        return 'France';
      case 'GF':
        return 'French Guiana';
      case 'PF':
        return 'French Polynesia';
      case 'TF':
        return 'French Southern Territories';
      case 'GA':
        return 'Gabon';
      case 'GM':
        return 'Gambia';
      case 'GE':
        return 'Georgia';
      case 'DE':
        return 'Germany';
      case 'GH':
        return 'Ghana';
      case 'GI':
        return 'Gibraltar';
      case 'GR':
        return 'Greece';
      case 'GL':
        return 'Greenland';
      case 'GD':
        return 'Grenada';
      case 'GP':
        return 'Guadeloupe';
      case 'GU':
        return 'Guam';
      case 'GT':
        return 'Guatemala';
      case 'GG':
        return 'Guernsey';
      case 'GN':
        return 'Guinea';
      case 'GW':
        return 'Guinea-Bissau';
      case 'GY':
        return 'Guyana';
      case 'HT':
        return 'Haiti';
      case 'HM':
        return 'Heard Island and McDonald Islands';
      case 'VA':
        return 'Holy See';
      case 'HN':
        return 'Honduras';
      case 'HK':
        return 'Hong Kong';
      case 'HU':
        return 'Hungary';
      case 'IS':
        return 'Iceland';
      case 'IN':
        return 'India';
      case 'ID':
        return 'Indonesia';
      case 'IR':
        return 'Iran';
      case 'IQ':
        return 'Iraq';
      case 'IE':
        return 'Ireland';
      case 'IM':
        return 'Isle of Man';
      case 'IL':
        return 'Israel';
      case 'IT':
        return 'Italy';
      case 'JM':
        return 'Jamaica';
      case 'JP':
        return 'Japan';
      case 'JE':
        return 'Jersey';
      case 'JO':
        return 'Jordan';
      case 'KZ':
        return 'Kazakhstan';
      case 'KE':
        return 'Kenya';
      case 'KI':
        return 'Kiribati';
      case 'KP':
        return 'North Korea';
      case 'KR':
        return 'South Korea';
      case 'KW':
        return 'Kuwait';
      case 'KG':
        return 'Kyrgyzstan';
      case 'LA':
        return 'Lao People\'s Democratic Republic';
      case 'LV':
        return 'Latvia';
      case 'LB':
        return 'Lebanon';
      case 'LS':
        return 'Lesotho';
      case 'LR':
        return 'Liberia';
      case 'LY':
        return 'Libya';
      case 'LI':
        return 'Liechtenstein';
      case 'LT':
        return 'Lithuania';
      case 'LU':
        return 'Luxembourg';
      case 'MO':
        return 'Macao';
      case 'MK':
        return 'North Macedonia';
      case 'MG':
        return 'Madagascar';
      case 'MW':
        return 'Malawi';
      case 'MY':
        return 'Malaysia';
      case 'MV':
        return 'Maldives';
      case 'ML':
        return 'Mali';
      case 'MT':
        return 'Malta';
      case 'MH':
        return 'Marshall Islands';
      case 'MQ':
        return 'Martinique';
      case 'MR':
        return 'Mauritania';
      case 'MU':
        return 'Mauritius';
      case 'YT':
        return 'Mayotte';
      case 'MX':
        return 'Mexico';
      case 'FM':
        return 'Micronesia';
      case 'MD':
        return 'Moldova';
      case 'MC':
        return 'Monaco';
      case 'MN':
        return 'Mongolia';
      case 'ME':
        return 'Montenegro';
      case 'MS':
        return 'Montserrat';
      case 'MA':
        return 'Morocco';
      case 'MZ':
        return 'Mozambique';
      case 'MM':
        return 'Myanmar';
      case 'NA':
        return 'Namibia';
      case 'NR':
        return 'Nauru';
      case 'NP':
        return 'Nepal';
      case 'NL':
        return 'Netherlands';
      case 'NC':
        return 'New Caledonia';
      case 'NZ':
        return 'New Zealand';
      case 'NI':
        return 'Nicaragua';
      case 'NE':
        return 'Niger';
      case 'NG':
        return 'Nigeria';
      case 'NU':
        return 'Niue';
      case 'NF':
        return 'Norfolk Island';
      case 'MP':
        return 'Northern Mariana Islands';
      case 'NO':
        return 'Norway';
      case 'OM':
        return 'Oman';
      case 'PK':
        return 'Pakistan';
      case 'PW':
        return 'Palau';
      case 'PS':
        return 'Palestine';
      case 'PA':
        return 'Panama';
      case 'PG':
        return 'Papua New Guinea';
      case 'PY':
        return 'Paraguay';
      case 'PE':
        return 'Peru';
      case 'PH':
        return 'Philippines';
      case 'PN':
        return 'Pitcairn';
      case 'PL':
        return 'Poland';
      case 'PT':
        return 'Portugal';
      case 'PR':
        return 'Puerto Rico';
      case 'QA':
        return 'Qatar';
      case 'RE':
        return 'Réunion';
      case 'RO':
        return 'Romania';
      case 'RU':
        return 'Russia';
      case 'RW':
        return 'Rwanda';
      case 'BL':
        return 'Saint Barthélemy';
      case 'SH':
        return 'Saint Helena';
      case 'KN':
        return 'Saint Kitts and Nevis';
      case 'LC':
        return 'Saint Lucia';
      case 'MF':
        return 'Saint Martin (French part)';
      case 'PM':
        return 'Saint Pierre and Miquelon';
      case 'VC':
        return 'Saint Vincent and the Grenadines';
      case 'WS':
        return 'Samoa';
      case 'SM':
        return 'San Marino';
      case 'ST':
        return 'Sao Tome and Principe';
      case 'SA':
        return 'Saudi Arabia';
      case 'SN':
        return 'Senegal';
      case 'RS':
        return 'Serbia';
      case 'SC':
        return 'Seychelles';
      case 'SL':
        return 'Sierra Leone';
      case 'SG':
        return 'Singapore';
      case 'SX':
        return 'Sint Maarten (Dutch part)';
      case 'SK':
        return 'Slovakia';
      case 'SI':
        return 'Slovenia';
      case 'SB':
        return 'Solomon Islands';
      case 'SO':
        return 'Somalia';
      case 'ZA':
        return 'South Africa';
      case 'GS':
        return 'South Georgia and the South Sandwich Islands';
      case 'SS':
        return 'South Sudan';
      case 'ES':
        return 'Spain';
      case 'LK':
        return 'Sri Lanka';
      case 'SD':
        return 'Sudan';
      case 'SR':
        return 'Suriname';
      case 'SJ':
        return 'Svalbard and Jan Mayen';
      case 'SE':
        return 'Sweden';
      case 'CH':
        return 'Switzerland';
      case 'SY':
        return 'Syria';
      case 'TW':
        return 'Taiwan';
      case 'TJ':
        return 'Tajikistan';
      case 'TZ':
        return 'Tanzania';
      case 'TH':
        return 'Thailand';
      case 'TL':
        return 'Timor-Leste';
      case 'TG':
        return 'Togo';
      case 'TK':
        return 'Tokelau';
      case 'TO':
        return 'Tonga';
      case 'TT':
        return 'Trinidad and Tobago';
      case 'TN':
        return 'Tunisia';
      case 'TR':
        return 'Turkey';
      case 'TM':
        return 'Turkmenistan';
      case 'TC':
        return 'Turks and Caicos Islands';
      case 'TV':
        return 'Tuvalu';
      case 'UG':
        return 'Uganda';
      case 'UA':
        return 'Ukraine';
      case 'AE':
        return 'United Arab Emirates';
      case 'GB':
        return 'United Kingdom';
      case 'US':
        return 'United States';
      case 'UM':
        return 'United States Minor Outlying Islands';
      case 'UY':
        return 'Uruguay';
      case 'UZ':
        return 'Uzbekistan';
      case 'VU':
        return 'Vanuatu';
      case 'VE':
        return 'Venezuela';
      case 'VN':
        return 'Vietnam';
      case 'VG':
        return 'Virgin Islands (British)';
      case 'VI':
        return 'Virgin Islands (U.S.)';
      case 'WF':
        return 'Wallis and Futuna';
      case 'EH':
        return 'Western Sahara';
      case 'YE':
        return 'Yemen';
      case 'ZM':
        return 'Zambia';
      case 'ZW':
        return 'Zimbabwe';
      case 'XK':
        return 'Kosovo';
      case 'EU':
        return 'European Union';
      case 'UN':
        return 'United Nations';
      default:
        return countryCode.toUpperCase();
    }
  }

  // Additional useful methods

  // Get flag emoji from country code
  static String getFlagEmoji(String countryCode) {
    final code = countryCode.toUpperCase();
    if (code.length != 2) return '🏳️';

    // Convert to regional indicator symbols
    final first = code.codeUnitAt(0) - 0x41 + 0x1F1E6;
    final second = code.codeUnitAt(1) - 0x41 + 0x1F1E6;

    return String.fromCharCodes([first, second]);
  }

  // Get continent for a country
  static String getContinent(String countryCode) {
    final code = countryCode.toUpperCase();

    // Africa
    final africa = {
      'DZ',
      'AO',
      'BJ',
      'BW',
      'BF',
      'BI',
      'CV',
      'CM',
      'CF',
      'TD',
      'KM',
      'CG',
      'CD',
      'CI',
      'DJ',
      'EG',
      'GQ',
      'ER',
      'SZ',
      'ET',
      'GA',
      'GM',
      'GH',
      'GN',
      'GW',
      'KE',
      'LS',
      'LR',
      'LY',
      'MG',
      'MW',
      'ML',
      'MR',
      'MU',
      'MA',
      'MZ',
      'NA',
      'NE',
      'NG',
      'RW',
      'ST',
      'SN',
      'SC',
      'SL',
      'SO',
      'ZA',
      'SS',
      'SD',
      'TZ',
      'TG',
      'TN',
      'UG',
      'ZM',
      'ZW',
    };

    // Asia
    final asia = {
      'AF',
      'AM',
      'AZ',
      'BH',
      'BD',
      'BT',
      'BN',
      'KH',
      'CN',
      'CY',
      'GE',
      'IN',
      'ID',
      'IR',
      'IQ',
      'IL',
      'JP',
      'JO',
      'KZ',
      'KW',
      'KG',
      'LA',
      'LB',
      'MY',
      'MV',
      'MN',
      'MM',
      'NP',
      'KP',
      'OM',
      'PK',
      'PH',
      'QA',
      'SA',
      'SG',
      'KR',
      'LK',
      'SY',
      'TW',
      'TJ',
      'TH',
      'TL',
      'TR',
      'TM',
      'AE',
      'UZ',
      'VN',
      'YE',
      'PS',
    };

    // Europe
    final europe = {
      'AL',
      'AD',
      'AT',
      'BY',
      'BE',
      'BA',
      'BG',
      'HR',
      'CZ',
      'DK',
      'EE',
      'FI',
      'FR',
      'DE',
      'GR',
      'HU',
      'IS',
      'IE',
      'IT',
      'LV',
      'LI',
      'LT',
      'LU',
      'MT',
      'MD',
      'MC',
      'ME',
      'NL',
      'MK',
      'NO',
      'PL',
      'PT',
      'RO',
      'RU',
      'SM',
      'RS',
      'SK',
      'SI',
      'ES',
      'SE',
      'CH',
      'UA',
      'GB',
      'VA',
      'XK',
    };

    // North America
    final northAmerica = {
      'AG',
      'BS',
      'BB',
      'BZ',
      'CA',
      'CR',
      'CU',
      'DM',
      'DO',
      'SV',
      'GD',
      'GT',
      'HT',
      'HN',
      'JM',
      'MX',
      'NI',
      'PA',
      'KN',
      'LC',
      'VC',
      'TT',
      'US',
    };

    // South America
    final southAmerica = {
      'AR',
      'BO',
      'BR',
      'CL',
      'CO',
      'EC',
      'GY',
      'PY',
      'PE',
      'SR',
      'UY',
      'VE',
    };

    // Oceania
    final oceania = {
      'AU',
      'FJ',
      'KI',
      'MH',
      'FM',
      'NR',
      'NZ',
      'PW',
      'PG',
      'WS',
      'SB',
      'TO',
      'TV',
      'VU',
    };

    if (africa.contains(code)) return 'Africa';
    if (asia.contains(code)) return 'Asia';
    if (europe.contains(code)) return 'Europe';
    if (northAmerica.contains(code)) return 'North America';
    if (southAmerica.contains(code)) return 'South America';
    if (oceania.contains(code)) return 'Oceania';

    return 'Unknown';
  }

  // Get time zone for a country
  static List<String> getTimeZones(String countryCode) {
    final Map<String, List<String>> timeZones = {
      'US': ['EST', 'CST', 'MST', 'PST', 'AKST', 'HST'],
      'GB': ['GMT', 'BST'],
      'JP': ['JST'],
      'AU': ['AEST', 'ACST', 'AWST'],
      'RU': [
        'MSK',
        'YEKT',
        'OMST',
        'KRAT',
        'IRKT',
        'YAKT',
        'VLAT',
        'MAGT',
        'PETT',
        'ANAT',
      ],
      'CN': ['CST'],
      'IN': ['IST'],
      'BR': ['BRT', 'AMT', 'ACT', 'FNT', 'BOT'],
      'ZA': ['SAST'],
      'KE': ['EAT'],
      'NG': ['WAT'],
      'EG': ['EET'],
      'MX': ['CST', 'MST', 'PST'],
      'CA': ['EST', 'CST', 'MST', 'PST', 'AST', 'NST'],
    };

    return timeZones[countryCode.toUpperCase()] ?? ['UTC'];
  }

  // Get currency for a country
  static String getCurrency(String countryCode) {
    final Map<String, String> currencies = {
      'US': 'USD',
      'GB': 'GBP',
      'JP': 'JPY',
      'EU': 'EUR',
      'CN': 'CNY',
      'IN': 'INR',
      'BR': 'BRL',
      'ZA': 'ZAR',
      'KE': 'KES',
      'NG': 'NGN',
      'EG': 'EGP',
      'MX': 'MXN',
      'CA': 'CAD',
      'AU': 'AUD',
      'RU': 'RUB',
      'KR': 'KRW',
      'CH': 'CHF',
      'SE': 'SEK',
      'NO': 'NOK',
      'DK': 'DKK',
      'PL': 'PLN',
      'HU': 'HUF',
      'CZ': 'CZK',
      'RO': 'RON',
      'BG': 'BGN',
      'TR': 'TRY',
      'SA': 'SAR',
      'AE': 'AED',
      'IL': 'ILS',
      'TH': 'THB',
      'VN': 'VND',
      'MY': 'MYR',
      'SG': 'SGD',
      'ID': 'IDR',
      'PH': 'PHP',
      'PK': 'PKR',
      'BD': 'BDT',
      'LK': 'LKR',
      'NP': 'NPR',
      'MM': 'MMK',
      'KH': 'KHR',
      'LA': 'LAK',
      'MN': 'MNT',
      'UZ': 'UZS',
      'KZ': 'KZT',
      'AZ': 'AZN',
      'GE': 'GEL',
      'AM': 'AMD',
      'BY': 'BYN',
      'UA': 'UAH',
      'MD': 'MDL',
      'RS': 'RSD',
      'HR': 'HRK',
      'BA': 'BAM',
      'AL': 'ALL',
      'MK': 'MKD',
      'ME': 'EUR',
      'XK': 'EUR',
      'IS': 'ISK',
      'FO': 'DKK',
      'GL': 'DKK',
      'NU': 'NZD',
      'CK': 'NZD',
      'WS': 'WST',
      'TO': 'TOP',
      'FJ': 'FJD',
      'VU': 'VUV',
      'SB': 'SBD',
      'KI': 'AUD',
      'TV': 'AUD',
      'FM': 'USD',
      'MH': 'USD',
      'PW': 'USD',
      'NR': 'AUD',
      'PG': 'PGK',
      'TL': 'USD',
      'GU': 'USD',
      'MP': 'USD',
      'PR': 'USD',
      'VI': 'USD',
      'AS': 'USD',
      'UM': 'USD',
      'AI': 'XCD',
      'AG': 'XCD',
      'DM': 'XCD',
      'GD': 'XCD',
      'KN': 'XCD',
      'LC': 'XCD',
      'VC': 'XCD',
      'TT': 'TTD',
      'BB': 'BBD',
      'BS': 'BSD',
      'BM': 'BMD',
      'KY': 'KYD',
      'TC': 'USD',
      'VG': 'USD',
      'MS': 'XCD',
      'BL': 'EUR',
      'MF': 'EUR',
      'GP': 'EUR',
      'MQ': 'EUR',
      'RE': 'EUR',
      'YT': 'EUR',
      'PM': 'EUR',
      'WF': 'XPF',
      'PF': 'XPF',
      'NC': 'XPF',
      'TK': 'NZD',
      'NU': 'NZD',
      'CK': 'NZD',
      'WS': 'WST',
      'TO': 'TOP',
      'FJ': 'FJD',
      'VU': 'VUV',
      'SB': 'SBD',
      'KI': 'AUD',
      'TV': 'AUD',
      'FM': 'USD',
      'MH': 'USD',
      'PW': 'USD',
      'NR': 'AUD',
      'PG': 'PGK',
      'TL': 'USD',
      'GU': 'USD',
      'MP': 'USD',
      'PR': 'USD',
      'VI': 'USD',
      'AS': 'USD',
      'UM': 'USD',
      'AI': 'XCD',
      'AG': 'XCD',
      'DM': 'XCD',
      'GD': 'XCD',
      'KN': 'XCD',
      'LC': 'XCD',
      'VC': 'XCD',
      'TT': 'TTD',
      'BB': 'BBD',
      'BS': 'BSD',
      'BM': 'BMD',
      'KY': 'KYD',
      'TC': 'USD',
      'VG': 'USD',
      'MS': 'XCD',
    };

    return currencies[countryCode.toUpperCase()] ?? 'Unknown';
  }

  // Get phone calling code for a country
  static String getCallingCode(String countryCode) {
    final Map<String, String> callingCodes = {
      'US': '+1',
      'GB': '+44',
      'FR': '+33',
      'DE': '+49',
      'IT': '+39',
      'ES': '+34',
      'JP': '+81',
      'CN': '+86',
      'IN': '+91',
      'BR': '+55',
      'RU': '+7',
      'CA': '+1',
      'AU': '+61',
      'MX': '+52',
      'ZA': '+27',
      'NG': '+234',
      'KE': '+254',
      'EG': '+20',
      'SA': '+966',
      'AE': '+971',
      'KR': '+82',
      'ID': '+62',
      'TR': '+90',
      'NL': '+31',
      'SE': '+46',
      'NO': '+47',
      'DK': '+45',
      'FI': '+358',
      'PL': '+48',
      'CH': '+41',
      'AT': '+43',
      'BE': '+32',
      'PT': '+351',
      'IE': '+353',
      'GR': '+30',
      'CZ': '+420',
      'RO': '+40',
      'HU': '+36',
      'BG': '+359',
      'RS': '+381',
      'HR': '+385',
      'SI': '+386',
      'SK': '+421',
      'LT': '+370',
      'LV': '+371',
      'EE': '+372',
      'LU': '+352',
      'MT': '+356',
      'CY': '+357',
      'IS': '+354',
      'AL': '+355',
      'MK': '+389',
      'ME': '+382',
      'XK': '+383',
      'BY': '+375',
      'UA': '+380',
      'MD': '+373',
      'AM': '+374',
      'AZ': '+994',
      'GE': '+995',
      'KZ': '+7',
      'UZ': '+998',
      'TJ': '+992',
      'KG': '+996',
      'TM': '+993',
      'TH': '+66',
      'VN': '+84',
      'MY': '+60',
      'SG': '+65',
      'PH': '+63',
      'BD': '+880',
      'PK': '+92',
      'LK': '+94',
      'NP': '+977',
      'MM': '+95',
      'KH': '+855',
      'LA': '+856',
      'MN': '+976',
      'BT': '+975',
      'MV': '+960',
      'BN': '+673',
      'TL': '+670',
      'FJ': '+679',
      'PG': '+675',
      'SB': '+677',
      'VU': '+678',
      'TO': '+676',
      'WS': '+685',
      'KI': '+686',
      'TV': '+688',
      'NR': '+674',
      'MH': '+692',
      'FM': '+691',
      'PW': '+680',
      'CK': '+682',
      'NU': '+683',
      'TK': '+690',
      'WF': '+681',
      'PF': '+689',
      'NC': '+687',
      'RE': '+262',
      'YT': '+262',
      'GP': '+590',
      'MQ': '+596',
      'GF': '+594',
      'BL': '+590',
      'MF': '+590',
      'PM': '+508',
      'GL': '+299',
      'FO': '+298',
      'SJ': '+47',
      'AX': '+358',
      'AI': '+1',
      'AG': '+1',
      'BS': '+1',
      'BB': '+1',
      'BM': '+1',
      'VG': '+1',
      'KY': '+1',
      'DM': '+1',
      'DO': '+1',
      'GD': '+1',
      'GU': '+1',
      'JM': '+1',
      'MS': '+1',
      'MP': '+1',
      'PR': '+1',
      'KN': '+1',
      'LC': '+1',
      'VC': '+1',
      'TT': '+1',
      'TC': '+1',
      'VI': '+1',
      'AS': '+1',
      'UM': '+1',
      'AW': '+297',
      'BQ': '+599',
      'CW': '+599',
      'SX': '+1',
      'SR': '+597',
      'UY': '+598',
      'PY': '+595',
      'BO': '+591',
      'CL': '+56',
      'CO': '+57',
      'EC': '+593',
      'GY': '+592',
      'PE': '+51',
      'VE': '+58',
      'AR': '+54',
      'BR': '+55',
      'BO': '+591',
      'CL': '+56',
      'CO': '+57',
      'EC': '+593',
      'GY': '+592',
      'PE': '+51',
      'PY': '+595',
      'SR': '+597',
      'UY': '+598',
      'VE': '+58',
      'FK': '+500',
      'GS': '+500',
      'TF': '+262',
      'HM': '+672',
      'AQ': '+672',
      'BV': '+47',
      'IO': '+246',
      'CX': '+61',
      'CC': '+61',
      'NF': '+672',
      'PN': '+64',
      'SH': '+290',
      'TA': '+290',
      'AC': '+247',
      'DG': '+246',
      'EA': '+34',
      'IC': '+34',
      'CP': '+262',
      'XK': '+383',
      'SS': '+211',
      'EH': '+212',
    };

    return callingCodes[countryCode.toUpperCase()] ?? 'Unknown';
  }
}
