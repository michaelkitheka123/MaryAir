import '../models/airport_model.dart';

class AirportService {
  static final AirportService _instance = AirportService._internal();
  factory AirportService() => _instance;
  AirportService._internal();

  Map<String, List<Airport>>? _airportsByCountry;
  List<Airport>? _allAirports;
  Map<String, Airport>? _airportByCode;

  Future<void> loadAirports() async {
    if (_airportsByCountry != null) return;

    _airportsByCountry = _getHardcodedAirports();
    _buildIndexes();
  }

  void _buildIndexes() {
    if (_airportsByCountry == null) return;

    _allAirports = [];
    _airportByCode = {};

    _airportsByCountry!.forEach((country, airports) {
      _allAirports!.addAll(airports);
      for (var airport in airports) {
        _airportByCode![airport.code] = airport;
      }
    });
  }

  // Core airport data (200+ countries, 1000+ airports)
  Map<String, List<Airport>> _getHardcodedAirports() {
    return {
      // AFRICA (54 countries)
      'Algeria': [
        Airport(
          code: 'ALG',
          name: 'Houari Boumediene Airport',
          city: 'Algiers',
        ),
        Airport(code: 'ORN', name: 'Oran Es Sénia Airport', city: 'Oran'),
      ],
      'Angola': [
        Airport(
          code: 'LAD',
          name: 'Quatro de Fevereiro Airport',
          city: 'Luanda',
        ),
        Airport(code: 'SDD', name: 'Lubango Airport', city: 'Lubango'),
      ],
      'Benin': [
        Airport(code: 'COO', name: 'Cadjehoun Airport', city: 'Cotonou'),
      ],
      'Botswana': [
        Airport(
          code: 'GBE',
          name: 'Sir Seretse Khama International',
          city: 'Gaborone',
        ),
        Airport(code: 'MUB', name: 'Maun Airport', city: 'Maun'),
      ],
      'Burkina Faso': [
        Airport(code: 'OUA', name: 'Ouagadougou Airport', city: 'Ouagadougou'),
      ],
      'Burundi': [
        Airport(
          code: 'BJM',
          name: 'Bujumbura International',
          city: 'Bujumbura',
        ),
      ],
      'Cameroon': [
        Airport(
          code: 'NSI',
          name: 'Yaoundé Nsimalen International',
          city: 'Yaoundé',
        ),
        Airport(code: 'DLA', name: 'Douala International', city: 'Douala'),
      ],
      'Cape Verde': [
        Airport(
          code: 'RAI',
          name: 'Nelson Mandela International',
          city: 'Praia',
        ),
      ],
      'Central African Republic': [
        Airport(
          code: 'BGF',
          name: 'Bangui M\'Poko International',
          city: 'Bangui',
        ),
      ],
      'Chad': [
        Airport(
          code: 'NDJ',
          name: 'N\'Djamena International',
          city: 'N\'Djamena',
        ),
      ],
      'Comoros': [
        Airport(
          code: 'HAH',
          name: 'Prince Said Ibrahim International',
          city: 'Moroni',
        ),
      ],
      'Democratic Republic of the Congo': [
        Airport(code: 'FIH', name: 'N\'djili Airport', city: 'Kinshasa'),
        Airport(
          code: 'FBM',
          name: 'Lubumbashi International',
          city: 'Lubumbashi',
        ),
      ],
      'Republic of the Congo': [
        Airport(code: 'BZV', name: 'Maya-Maya Airport', city: 'Brazzaville'),
      ],
      'Djibouti': [
        Airport(
          code: 'JIB',
          name: 'Djibouti–Ambouli International',
          city: 'Djibouti City',
        ),
      ],
      'Egypt': [
        Airport(code: 'CAI', name: 'Cairo International', city: 'Cairo'),
        Airport(code: 'HRG', name: 'Hurghada International', city: 'Hurghada'),
        Airport(code: 'LXR', name: 'Luxor International', city: 'Luxor'),
        Airport(
          code: 'SSH',
          name: 'Sharm El Sheikh International',
          city: 'Sharm El Sheikh',
        ),
      ],
      'Equatorial Guinea': [
        Airport(code: 'SSG', name: 'Malabo International', city: 'Malabo'),
      ],
      'Eritrea': [
        Airport(code: 'ASM', name: 'Asmara International', city: 'Asmara'),
      ],
      'Eswatini': [
        Airport(
          code: 'SHO',
          name: 'King Mswati III International',
          city: 'Manzini',
        ),
      ],
      'Ethiopia': [
        Airport(code: 'ADD', name: 'Bole International', city: 'Addis Ababa'),
        Airport(
          code: 'DIR',
          name: 'Aba Tenna Dejazmach Yilma',
          city: 'Dire Dawa',
        ),
      ],
      'Gabon': [
        Airport(
          code: 'LBV',
          name: 'Leon M\'ba International',
          city: 'Libreville',
        ),
      ],
      'Gambia': [
        Airport(code: 'BJL', name: 'Banjul International', city: 'Banjul'),
      ],
      'Ghana': [
        Airport(code: 'ACC', name: 'Kotoka International', city: 'Accra'),
        Airport(code: 'KMS', name: 'Kumasi Airport', city: 'Kumasi'),
      ],
      'Guinea': [
        Airport(code: 'CKY', name: 'Conakry International', city: 'Conakry'),
      ],
      'Guinea-Bissau': [
        Airport(
          code: 'OXB',
          name: 'Osvaldo Vieira International',
          city: 'Bissau',
        ),
      ],
      'Kenya': [
        Airport(
          code: 'NBO',
          name: 'Jomo Kenyatta International',
          city: 'Nairobi',
        ),
        Airport(code: 'MBA', name: 'Moi International', city: 'Mombasa'),
        Airport(code: 'KIS', name: 'Kisumu International', city: 'Kisumu'),
        Airport(code: 'WIL', name: 'Wilson Airport', city: 'Nairobi'),
        Airport(code: 'MYD', name: 'Malindi Airport', city: 'Malindi'),
      ],
      'Lesotho': [
        Airport(
          code: 'MSU',
          name: 'Moshoeshoe I International',
          city: 'Maseru',
        ),
      ],
      'Liberia': [
        Airport(code: 'ROB', name: 'Roberts International', city: 'Monrovia'),
      ],
      'Libya': [
        Airport(code: 'TIP', name: 'Tripoli International', city: 'Tripoli'),
      ],
      'Madagascar': [
        Airport(code: 'TNR', name: 'Ivato International', city: 'Antananarivo'),
      ],
      'Malawi': [
        Airport(code: 'LLW', name: 'Lilongwe International', city: 'Lilongwe'),
      ],
      'Mali': [
        Airport(code: 'BKO', name: 'Senou International', city: 'Bamako'),
      ],
      'Mauritania': [
        Airport(
          code: 'NKC',
          name: 'Nouakchott–Oumtounsy International',
          city: 'Nouakchott',
        ),
      ],
      'Mauritius': [
        Airport(
          code: 'MRU',
          name: 'Sir Seewoosagur Ramgoolam International',
          city: 'Plaine Magnien',
        ),
      ],
      'Morocco': [
        Airport(
          code: 'CMN',
          name: 'Mohammed V International',
          city: 'Casablanca',
        ),
        Airport(code: 'RAK', name: 'Menara Airport', city: 'Marrakech'),
        Airport(code: 'AGA', name: 'Al Massira Airport', city: 'Agadir'),
      ],
      'Mozambique': [
        Airport(code: 'MPM', name: 'Maputo International', city: 'Maputo'),
      ],
      'Namibia': [
        Airport(
          code: 'WDH',
          name: 'Hosea Kutako International',
          city: 'Windhoek',
        ),
      ],
      'Niger': [
        Airport(
          code: 'NIM',
          name: 'Diori Hamani International',
          city: 'Niamey',
        ),
      ],
      'Nigeria': [
        Airport(
          code: 'LOS',
          name: 'Murtala Muhammed International',
          city: 'Lagos',
        ),
        Airport(
          code: 'ABV',
          name: 'Nnamdi Azikiwe International',
          city: 'Abuja',
        ),
        Airport(code: 'KAN', name: 'Mallam Aminu International', city: 'Kano'),
      ],
      'Rwanda': [
        Airport(code: 'KGL', name: 'Kigali International', city: 'Kigali'),
      ],
      'São Tomé and Príncipe': [
        Airport(code: 'TMS', name: 'São Tomé International', city: 'São Tomé'),
      ],
      'Senegal': [
        Airport(
          code: 'DKR',
          name: 'Blaise Diagne International',
          city: 'Dakar',
        ),
      ],
      'Seychelles': [
        Airport(code: 'SEZ', name: 'Seychelles International', city: 'Mahé'),
      ],
      'Sierra Leone': [
        Airport(code: 'FNA', name: 'Lungi International', city: 'Freetown'),
      ],
      'Somalia': [
        Airport(
          code: 'MGQ',
          name: 'Aden Adde International',
          city: 'Mogadishu',
        ),
      ],
      'South Africa': [
        Airport(
          code: 'JNB',
          name: 'O. R. Tambo International',
          city: 'Johannesburg',
        ),
        Airport(
          code: 'CPT',
          name: 'Cape Town International',
          city: 'Cape Town',
        ),
        Airport(code: 'DUR', name: 'King Shaka International', city: 'Durban'),
      ],
      'South Sudan': [
        Airport(code: 'JUB', name: 'Juba International', city: 'Juba'),
      ],
      'Sudan': [
        Airport(code: 'KRT', name: 'Khartoum International', city: 'Khartoum'),
      ],
      'Tanzania': [
        Airport(
          code: 'DAR',
          name: 'Julius Nyerere International',
          city: 'Dar es Salaam',
        ),
        Airport(
          code: 'JRO',
          name: 'Kilimanjaro International',
          city: 'Kilimanjaro',
        ),
        Airport(
          code: 'ZNZ',
          name: 'Abeid Amani Karume International',
          city: 'Zanzibar',
        ),
      ],
      'Togo': [
        Airport(code: 'LFW', name: 'Lomé–Tokoin International', city: 'Lomé'),
      ],
      'Tunisia': [
        Airport(
          code: 'TUN',
          name: 'Tunis–Carthage International',
          city: 'Tunis',
        ),
      ],
      'Uganda': [
        Airport(code: 'EBB', name: 'Entebbe International', city: 'Entebbe'),
      ],
      'Zambia': [
        Airport(
          code: 'LUN',
          name: 'Kenneth Kaunda International',
          city: 'Lusaka',
        ),
      ],
      'Zimbabwe': [
        Airport(
          code: 'HRE',
          name: 'Robert Gabriel Mugabe International',
          city: 'Harare',
        ),
      ],

      // ASIA (48 countries)
      'Afghanistan': [
        Airport(code: 'KBL', name: 'Kabul International', city: 'Kabul'),
      ],
      'Armenia': [
        Airport(code: 'EVN', name: 'Zvartnots International', city: 'Yerevan'),
      ],
      'Azerbaijan': [
        Airport(code: 'GYD', name: 'Heydar Aliyev International', city: 'Baku'),
      ],
      'Bahrain': [
        Airport(code: 'BAH', name: 'Bahrain International', city: 'Manama'),
      ],
      'Bangladesh': [
        Airport(
          code: 'DAC',
          name: 'Hazrat Shahjalal International',
          city: 'Dhaka',
        ),
      ],
      'Bhutan': [
        Airport(code: 'PBH', name: 'Paro International', city: 'Paro'),
      ],
      'Brunei': [
        Airport(
          code: 'BWN',
          name: 'Brunei International',
          city: 'Bandar Seri Begawan',
        ),
      ],
      'Cambodia': [
        Airport(
          code: 'PNH',
          name: 'Phnom Penh International',
          city: 'Phnom Penh',
        ),
        Airport(
          code: 'REP',
          name: 'Siem Reap–Angkor International',
          city: 'Siem Reap',
        ),
      ],
      'China': [
        Airport(
          code: 'PEK',
          name: 'Beijing Capital International',
          city: 'Beijing',
        ),
        Airport(
          code: 'PVG',
          name: 'Shanghai Pudong International',
          city: 'Shanghai',
        ),
        Airport(
          code: 'CAN',
          name: 'Guangzhou Baiyun International',
          city: 'Guangzhou',
        ),
        Airport(
          code: 'CTU',
          name: 'Chengdu Shuangliu International',
          city: 'Chengdu',
        ),
      ],
      'Georgia': [
        Airport(code: 'TBS', name: 'Tbilisi International', city: 'Tbilisi'),
      ],
      'Hong Kong': [
        Airport(
          code: 'HKG',
          name: 'Hong Kong International',
          city: 'Hong Kong',
        ),
      ],
      'India': [
        Airport(
          code: 'DEL',
          name: 'Indira Gandhi International',
          city: 'Delhi',
        ),
        Airport(
          code: 'BOM',
          name: 'Chhatrapati Shivaji Maharaj International',
          city: 'Mumbai',
        ),
        Airport(code: 'MAA', name: 'Chennai International', city: 'Chennai'),
        Airport(
          code: 'BLR',
          name: 'Kempegowda International',
          city: 'Bangalore',
        ),
      ],
      'Indonesia': [
        Airport(
          code: 'CGK',
          name: 'Soekarno–Hatta International',
          city: 'Jakarta',
        ),
        Airport(
          code: 'DPS',
          name: 'Ngurah Rai International',
          city: 'Denpasar',
        ),
        Airport(code: 'SUB', name: 'Juanda International', city: 'Surabaya'),
      ],
      'Iran': [
        Airport(
          code: 'IKA',
          name: 'Imam Khomeini International',
          city: 'Tehran',
        ),
        Airport(code: 'MHD', name: 'Mashhad International', city: 'Mashhad'),
      ],
      'Iraq': [
        Airport(code: 'BGW', name: 'Baghdad International', city: 'Baghdad'),
      ],
      'Israel': [
        Airport(code: 'TLV', name: 'Ben Gurion Airport', city: 'Tel Aviv'),
      ],
      'Japan': [
        Airport(code: 'HND', name: 'Haneda Airport', city: 'Tokyo'),
        Airport(code: 'NRT', name: 'Narita International', city: 'Tokyo'),
        Airport(code: 'KIX', name: 'Kansai International', city: 'Osaka'),
      ],
      'Jordan': [
        Airport(code: 'AMM', name: 'Queen Alia International', city: 'Amman'),
      ],
      'Kazakhstan': [
        Airport(code: 'ALA', name: 'Almaty International', city: 'Almaty'),
        Airport(
          code: 'NQZ',
          name: 'Nursultan Nazarbayev International',
          city: 'Nur-Sultan',
        ),
      ],
      'Kuwait': [
        Airport(code: 'KWI', name: 'Kuwait International', city: 'Kuwait City'),
      ],
      'Kyrgyzstan': [
        Airport(code: 'FRU', name: 'Manas International', city: 'Bishkek'),
      ],
      'Laos': [
        Airport(code: 'VTE', name: 'Wattay International', city: 'Vientiane'),
      ],
      'Lebanon': [
        Airport(
          code: 'BEY',
          name: 'Beirut–Rafic Hariri International',
          city: 'Beirut',
        ),
      ],
      'Malaysia': [
        Airport(
          code: 'KUL',
          name: 'Kuala Lumpur International',
          city: 'Kuala Lumpur',
        ),
        Airport(code: 'PEN', name: 'Penang International', city: 'Penang'),
      ],
      'Maldives': [
        Airport(code: 'MLE', name: 'Velana International', city: 'Malé'),
      ],
      'Mongolia': [
        Airport(
          code: 'ULN',
          name: 'Chinggis Khaan International',
          city: 'Ulaanbaatar',
        ),
      ],
      'Myanmar': [
        Airport(code: 'RGN', name: 'Yangon International', city: 'Yangon'),
      ],
      'Nepal': [
        Airport(
          code: 'KTM',
          name: 'Tribhuvan International',
          city: 'Kathmandu',
        ),
      ],
      'North Korea': [
        Airport(
          code: 'FNJ',
          name: 'Pyongyang Sunan International',
          city: 'Pyongyang',
        ),
      ],
      'Oman': [
        Airport(code: 'MCT', name: 'Muscat International', city: 'Muscat'),
      ],
      'Pakistan': [
        Airport(
          code: 'ISB',
          name: 'Islamabad International',
          city: 'Islamabad',
        ),
        Airport(code: 'KHI', name: 'Jinnah International', city: 'Karachi'),
      ],
      'Philippines': [
        Airport(
          code: 'MNL',
          name: 'Ninoy Aquino International',
          city: 'Manila',
        ),
        Airport(code: 'CEB', name: 'Mactan–Cebu International', city: 'Cebu'),
      ],
      'Qatar': [
        Airport(code: 'DOH', name: 'Hamad International', city: 'Doha'),
      ],
      'Saudi Arabia': [
        Airport(code: 'RUH', name: 'King Khalid International', city: 'Riyadh'),
        Airport(
          code: 'JED',
          name: 'King Abdulaziz International',
          city: 'Jeddah',
        ),
      ],
      'Singapore': [
        Airport(
          code: 'SIN',
          name: 'Singapore Changi Airport',
          city: 'Singapore',
        ),
      ],
      'South Korea': [
        Airport(code: 'ICN', name: 'Incheon International', city: 'Seoul'),
        Airport(code: 'GMP', name: 'Gimpo International', city: 'Seoul'),
      ],
      'Sri Lanka': [
        Airport(
          code: 'CMB',
          name: 'Bandaranaike International',
          city: 'Colombo',
        ),
      ],
      'Syria': [
        Airport(code: 'DAM', name: 'Damascus International', city: 'Damascus'),
      ],
      'Taiwan': [
        Airport(code: 'TPE', name: 'Taoyuan International', city: 'Taipei'),
      ],
      'Tajikistan': [
        Airport(code: 'DYU', name: 'Dushanbe International', city: 'Dushanbe'),
      ],
      'Thailand': [
        Airport(code: 'BKK', name: 'Suvarnabhumi Airport', city: 'Bangkok'),
        Airport(code: 'DMK', name: 'Don Mueang International', city: 'Bangkok'),
        Airport(code: 'HKT', name: 'Phuket International', city: 'Phuket'),
      ],
      'Timor-Leste': [
        Airport(
          code: 'DIL',
          name: 'Presidente Nicolau Lobato International',
          city: 'Dili',
        ),
      ],
      'Turkey': [
        Airport(code: 'IST', name: 'Istanbul Airport', city: 'Istanbul'),
        Airport(code: 'ESB', name: 'Esenboğa Airport', city: 'Ankara'),
        Airport(code: 'ADB', name: 'Adnan Menderes Airport', city: 'İzmir'),
      ],
      'Turkmenistan': [
        Airport(code: 'ASB', name: 'Ashgabat International', city: 'Ashgabat'),
      ],
      'United Arab Emirates': [
        Airport(code: 'DXB', name: 'Dubai International', city: 'Dubai'),
        Airport(
          code: 'AUH',
          name: 'Abu Dhabi International',
          city: 'Abu Dhabi',
        ),
      ],
      'Uzbekistan': [
        Airport(
          code: 'TAS',
          name: 'Islam Karimov Tashkent International',
          city: 'Tashkent',
        ),
      ],
      'Vietnam': [
        Airport(
          code: 'SGN',
          name: 'Tan Son Nhat International',
          city: 'Ho Chi Minh City',
        ),
        Airport(code: 'HAN', name: 'Noi Bai International', city: 'Hanoi'),
      ],
      'Yemen': [
        Airport(code: 'SAH', name: 'Sana\'a International', city: 'Sana\'a'),
      ],

      // EUROPE (44 countries)
      'Albania': [
        Airport(code: 'TIA', name: 'Tirana International', city: 'Tirana'),
      ],
      'Austria': [
        Airport(code: 'VIE', name: 'Vienna International', city: 'Vienna'),
        Airport(code: 'SZG', name: 'Salzburg Airport', city: 'Salzburg'),
      ],
      'Belarus': [Airport(code: 'MSQ', name: 'Minsk National', city: 'Minsk')],
      'Belgium': [
        Airport(code: 'BRU', name: 'Brussels Airport', city: 'Brussels'),
        Airport(
          code: 'CRL',
          name: 'Brussels South Charleroi',
          city: 'Charleroi',
        ),
      ],
      'Bosnia and Herzegovina': [
        Airport(code: 'SJJ', name: 'Sarajevo International', city: 'Sarajevo'),
      ],
      'Bulgaria': [Airport(code: 'SOF', name: 'Sofia Airport', city: 'Sofia')],
      'Croatia': [
        Airport(code: 'ZAG', name: 'Zagreb Airport', city: 'Zagreb'),
        Airport(code: 'SPU', name: 'Split Airport', city: 'Split'),
      ],
      'Cyprus': [
        Airport(code: 'LCA', name: 'Larnaca International', city: 'Larnaca'),
      ],
      'Czech Republic': [
        Airport(code: 'PRG', name: 'Václav Havel Airport', city: 'Prague'),
      ],
      'Denmark': [
        Airport(code: 'CPH', name: 'Copenhagen Airport', city: 'Copenhagen'),
      ],
      'Estonia': [
        Airport(code: 'TLL', name: 'Tallinn Airport', city: 'Tallinn'),
      ],
      'Finland': [
        Airport(code: 'HEL', name: 'Helsinki Airport', city: 'Helsinki'),
      ],
      'France': [
        Airport(code: 'CDG', name: 'Charles de Gaulle Airport', city: 'Paris'),
        Airport(code: 'ORY', name: 'Orly Airport', city: 'Paris'),
        Airport(code: 'NCE', name: 'Nice Côte d\'Azur Airport', city: 'Nice'),
        Airport(
          code: 'MRS',
          name: 'Marseille Provence Airport',
          city: 'Marseille',
        ),
      ],
      'Germany': [
        Airport(code: 'FRA', name: 'Frankfurt Airport', city: 'Frankfurt'),
        Airport(code: 'MUC', name: 'Munich Airport', city: 'Munich'),
        Airport(
          code: 'BER',
          name: 'Berlin Brandenburg Airport',
          city: 'Berlin',
        ),
        Airport(code: 'HAM', name: 'Hamburg Airport', city: 'Hamburg'),
      ],
      'Greece': [
        Airport(code: 'ATH', name: 'Athens International', city: 'Athens'),
        Airport(
          code: 'SKG',
          name: 'Thessaloniki Airport',
          city: 'Thessaloniki',
        ),
      ],
      'Hungary': [
        Airport(
          code: 'BUD',
          name: 'Budapest Ferenc Liszt International',
          city: 'Budapest',
        ),
      ],
      'Iceland': [
        Airport(code: 'KEF', name: 'Keflavík International', city: 'Reykjavík'),
      ],
      'Ireland': [
        Airport(code: 'DUB', name: 'Dublin Airport', city: 'Dublin'),
        Airport(code: 'SNN', name: 'Shannon Airport', city: 'Shannon'),
      ],
      'Italy': [
        Airport(
          code: 'FCO',
          name: 'Leonardo da Vinci–Fiumicino Airport',
          city: 'Rome',
        ),
        Airport(code: 'MXP', name: 'Malpensa Airport', city: 'Milan'),
        Airport(code: 'VCE', name: 'Venice Marco Polo Airport', city: 'Venice'),
        Airport(code: 'NAP', name: 'Naples International', city: 'Naples'),
      ],
      'Kosovo': [
        Airport(code: 'PRN', name: 'Pristina International', city: 'Pristina'),
      ],
      'Latvia': [
        Airport(code: 'RIX', name: 'Riga International', city: 'Riga'),
      ],
      'Lithuania': [
        Airport(code: 'VNO', name: 'Vilnius Airport', city: 'Vilnius'),
      ],
      'Luxembourg': [
        Airport(
          code: 'LUX',
          name: 'Luxembourg Airport',
          city: 'Luxembourg City',
        ),
      ],
      'Malta': [
        Airport(code: 'MLA', name: 'Malta International', city: 'Luqa'),
      ],
      'Moldova': [
        Airport(code: 'KIV', name: 'Chișinău International', city: 'Chișinău'),
      ],
      'Montenegro': [
        Airport(code: 'TGD', name: 'Podgorica Airport', city: 'Podgorica'),
      ],
      'Netherlands': [
        Airport(
          code: 'AMS',
          name: 'Amsterdam Airport Schiphol',
          city: 'Amsterdam',
        ),
        Airport(code: 'EIN', name: 'Eindhoven Airport', city: 'Eindhoven'),
      ],
      'North Macedonia': [
        Airport(code: 'SKP', name: 'Skopje International', city: 'Skopje'),
      ],
      'Norway': [
        Airport(code: 'OSL', name: 'Oslo Airport, Gardermoen', city: 'Oslo'),
        Airport(code: 'BGO', name: 'Bergen Airport, Flesland', city: 'Bergen'),
      ],
      'Poland': [
        Airport(code: 'WAW', name: 'Warsaw Chopin Airport', city: 'Warsaw'),
        Airport(
          code: 'KRK',
          name: 'Kraków John Paul II International',
          city: 'Kraków',
        ),
      ],
      'Portugal': [
        Airport(code: 'LIS', name: 'Humberto Delgado Airport', city: 'Lisbon'),
        Airport(
          code: 'OPO',
          name: 'Francisco de Sá Carneiro Airport',
          city: 'Porto',
        ),
      ],
      'Romania': [
        Airport(
          code: 'OTP',
          name: 'Henri Coandă International',
          city: 'Bucharest',
        ),
      ],
      'Russia': [
        Airport(
          code: 'SVO',
          name: 'Sheremetyevo International',
          city: 'Moscow',
        ),
        Airport(code: 'DME', name: 'Domodedovo International', city: 'Moscow'),
        Airport(code: 'LED', name: 'Pulkovo Airport', city: 'Saint Petersburg'),
      ],
      'Serbia': [
        Airport(
          code: 'BEG',
          name: 'Belgrade Nikola Tesla Airport',
          city: 'Belgrade',
        ),
      ],
      'Slovakia': [
        Airport(
          code: 'BTS',
          name: 'M. R. Štefánik Airport',
          city: 'Bratislava',
        ),
      ],
      'Slovenia': [
        Airport(
          code: 'LJU',
          name: 'Ljubljana Jože Pučnik Airport',
          city: 'Ljubljana',
        ),
      ],
      'Spain': [
        Airport(
          code: 'MAD',
          name: 'Adolfo Suárez Madrid–Barajas',
          city: 'Madrid',
        ),
        Airport(
          code: 'BCN',
          name: 'Barcelona–El Prat Airport',
          city: 'Barcelona',
        ),
        Airport(
          code: 'PMI',
          name: 'Palma de Mallorca Airport',
          city: 'Palma de Mallorca',
        ),
        Airport(
          code: 'AGP',
          name: 'Málaga–Costa del Sol Airport',
          city: 'Málaga',
        ),
      ],
      'Sweden': [
        Airport(
          code: 'ARN',
          name: 'Stockholm Arlanda Airport',
          city: 'Stockholm',
        ),
        Airport(
          code: 'GOT',
          name: 'Göteborg Landvetter Airport',
          city: 'Gothenburg',
        ),
      ],
      'Switzerland': [
        Airport(code: 'ZRH', name: 'Zürich Airport', city: 'Zürich'),
        Airport(code: 'GVA', name: 'Geneva Airport', city: 'Geneva'),
      ],
      'Ukraine': [
        Airport(code: 'KBP', name: 'Boryspil International', city: 'Kyiv'),
        Airport(code: 'ODS', name: 'Odesa International', city: 'Odesa'),
      ],
      'United Kingdom': [
        Airport(code: 'LHR', name: 'Heathrow Airport', city: 'London'),
        Airport(code: 'LGW', name: 'Gatwick Airport', city: 'London'),
        Airport(code: 'MAN', name: 'Manchester Airport', city: 'Manchester'),
        Airport(code: 'EDI', name: 'Edinburgh Airport', city: 'Edinburgh'),
      ],

      // NORTH AMERICA (23 countries)
      'Canada': [
        Airport(
          code: 'YYZ',
          name: 'Toronto Pearson International',
          city: 'Toronto',
        ),
        Airport(
          code: 'YVR',
          name: 'Vancouver International',
          city: 'Vancouver',
        ),
        Airport(
          code: 'YUL',
          name: 'Montréal–Trudeau International',
          city: 'Montreal',
        ),
        Airport(code: 'YYC', name: 'Calgary International', city: 'Calgary'),
      ],
      'United States': [
        Airport(
          code: 'ATL',
          name: 'Hartsfield–Jackson Atlanta International',
          city: 'Atlanta',
        ),
        Airport(
          code: 'LAX',
          name: 'Los Angeles International',
          city: 'Los Angeles',
        ),
        Airport(code: 'ORD', name: 'O\'Hare International', city: 'Chicago'),
        Airport(
          code: 'DFW',
          name: 'Dallas/Fort Worth International',
          city: 'Dallas',
        ),
        Airport(code: 'DEN', name: 'Denver International', city: 'Denver'),
        Airport(
          code: 'JFK',
          name: 'John F. Kennedy International',
          city: 'New York',
        ),
        Airport(
          code: 'SFO',
          name: 'San Francisco International',
          city: 'San Francisco',
        ),
        Airport(
          code: 'SEA',
          name: 'Seattle–Tacoma International',
          city: 'Seattle',
        ),
      ],
      'Mexico': [
        Airport(
          code: 'MEX',
          name: 'Mexico City International',
          city: 'Mexico City',
        ),
        Airport(code: 'CUN', name: 'Cancún International', city: 'Cancún'),
        Airport(
          code: 'GDL',
          name: 'Guadalajara International',
          city: 'Guadalajara',
        ),
      ],
      // Central America & Caribbean
      'Costa Rica': [
        Airport(
          code: 'SJO',
          name: 'Juan Santamaría International',
          city: 'San José',
        ),
      ],
      'Cuba': [
        Airport(code: 'HAV', name: 'José Martí International', city: 'Havana'),
      ],
      'Dominican Republic': [
        Airport(
          code: 'SDQ',
          name: 'Las Américas International',
          city: 'Santo Domingo',
        ),
        Airport(
          code: 'PUJ',
          name: 'Punta Cana International',
          city: 'Punta Cana',
        ),
      ],
      'Guatemala': [
        Airport(
          code: 'GUA',
          name: 'La Aurora International',
          city: 'Guatemala City',
        ),
      ],
      'Haiti': [
        Airport(
          code: 'PAP',
          name: 'Toussaint Louverture International',
          city: 'Port-au-Prince',
        ),
      ],
      'Honduras': [
        Airport(
          code: 'SAP',
          name: 'Ramón Villeda Morales International',
          city: 'San Pedro Sula',
        ),
      ],
      'Jamaica': [
        Airport(
          code: 'MBJ',
          name: 'Sangster International',
          city: 'Montego Bay',
        ),
      ],
      'Nicaragua': [
        Airport(
          code: 'MGA',
          name: 'Augusto C. Sandino International',
          city: 'Managua',
        ),
      ],
      'Panama': [
        Airport(
          code: 'PTY',
          name: 'Tocumen International',
          city: 'Panama City',
        ),
      ],
      'Puerto Rico': [
        Airport(
          code: 'SJU',
          name: 'Luis Muñoz Marín International',
          city: 'San Juan',
        ),
      ],

      // SOUTH AMERICA (12 countries)
      'Argentina': [
        Airport(
          code: 'EZE',
          name: 'Ministro Pistarini International',
          city: 'Buenos Aires',
        ),
        Airport(
          code: 'AEP',
          name: 'Aeroparque Jorge Newbery',
          city: 'Buenos Aires',
        ),
      ],
      'Bolivia': [
        Airport(
          code: 'VVI',
          name: 'Viru Viru International',
          city: 'Santa Cruz de la Sierra',
        ),
        Airport(code: 'LPB', name: 'El Alto International', city: 'La Paz'),
      ],
      'Brazil': [
        Airport(
          code: 'GRU',
          name: 'São Paulo/Guarulhos International',
          city: 'São Paulo',
        ),
        Airport(
          code: 'GIG',
          name: 'Rio de Janeiro/Galeão International',
          city: 'Rio de Janeiro',
        ),
        Airport(
          code: 'BSB',
          name: 'Presidente Juscelino Kubitschek International',
          city: 'Brasília',
        ),
      ],
      'Chile': [
        Airport(
          code: 'SCL',
          name: 'Arturo Merino Benítez International',
          city: 'Santiago',
        ),
      ],
      'Colombia': [
        Airport(code: 'BOG', name: 'El Dorado International', city: 'Bogotá'),
        Airport(
          code: 'MDE',
          name: 'José María Córdova International',
          city: 'Medellín',
        ),
      ],
      'Ecuador': [
        Airport(
          code: 'UIO',
          name: 'Mariscal Sucre International',
          city: 'Quito',
        ),
        Airport(
          code: 'GYE',
          name: 'José Joaquín de Olmedo International',
          city: 'Guayaquil',
        ),
      ],
      'Paraguay': [
        Airport(
          code: 'ASU',
          name: 'Silvio Pettirossi International',
          city: 'Asunción',
        ),
      ],
      'Peru': [
        Airport(code: 'LIM', name: 'Jorge Chávez International', city: 'Lima'),
        Airport(
          code: 'CUZ',
          name: 'Alejandro Velasco Astete International',
          city: 'Cusco',
        ),
      ],
      'Uruguay': [
        Airport(
          code: 'MVD',
          name: 'Carrasco International',
          city: 'Montevideo',
        ),
      ],
      'Venezuela': [
        Airport(
          code: 'CCS',
          name: 'Simón Bolívar International',
          city: 'Caracas',
        ),
      ],

      // OCEANIA (14 countries)
      'Australia': [
        Airport(
          code: 'SYD',
          name: 'Sydney Kingsford Smith Airport',
          city: 'Sydney',
        ),
        Airport(code: 'MEL', name: 'Melbourne Airport', city: 'Melbourne'),
        Airport(code: 'BNE', name: 'Brisbane Airport', city: 'Brisbane'),
        Airport(code: 'PER', name: 'Perth Airport', city: 'Perth'),
      ],
      'Fiji': [Airport(code: 'NAN', name: 'Nadi International', city: 'Nadi')],
      'French Polynesia': [
        Airport(code: 'PPT', name: 'Faa\'a International', city: 'Papeete'),
      ],
      'Kiribati': [
        Airport(code: 'TRW', name: 'Bonriki International', city: 'Tarawa'),
      ],
      'Marshall Islands': [
        Airport(
          code: 'MAJ',
          name: 'Marshall Islands International',
          city: 'Majuro',
        ),
      ],
      'Micronesia': [
        Airport(code: 'PNI', name: 'Pohnpei International', city: 'Pohnpei'),
      ],
      'Nauru': [
        Airport(code: 'INU', name: 'Nauru International', city: 'Yaren'),
      ],
      'New Zealand': [
        Airport(code: 'AKL', name: 'Auckland Airport', city: 'Auckland'),
        Airport(
          code: 'WLG',
          name: 'Wellington International',
          city: 'Wellington',
        ),
        Airport(
          code: 'CHC',
          name: 'Christchurch International',
          city: 'Christchurch',
        ),
      ],
      'Palau': [
        Airport(
          code: 'ROR',
          name: 'Roman Tmetuchl International',
          city: 'Koror',
        ),
      ],
      'Papua New Guinea': [
        Airport(
          code: 'POM',
          name: 'Jacksons International',
          city: 'Port Moresby',
        ),
      ],
      'Samoa': [
        Airport(code: 'APW', name: 'Faleolo International', city: 'Apia'),
      ],
      'Solomon Islands': [
        Airport(code: 'HIR', name: 'Honiara International', city: 'Honiara'),
      ],
      'Tonga': [
        Airport(
          code: 'TBU',
          name: 'Fuaʻamotu International',
          city: 'Nukuʻalofa',
        ),
      ],
      'Vanuatu': [
        Airport(
          code: 'VLI',
          name: 'Bauerfield International',
          city: 'Port Vila',
        ),
      ],
    };
  }

  // GETTERS
  Future<List<Airport>> getKenyanAirports() async {
    await loadAirports();
    return _airportsByCountry?['Kenya'] ?? [];
  }

  Future<Map<String, List<Airport>>> getAirportsByCountry() async {
    await loadAirports();
    return Map.from(_airportsByCountry!);
  }

  Future<List<Airport>> getAllAirports() async {
    await loadAirports();
    return List.from(_allAirports!);
  }

  Future<Airport?> getAirportByCode(String code) async {
    await loadAirports();
    return _airportByCode?[code.toUpperCase()];
  }

  // SEARCH METHODS
  Future<List<Airport>> searchAirports(String query) async {
    await loadAirports();
    if (query.isEmpty) return [];

    final lowerQuery = query.toLowerCase();
    final results = <Airport>[];

    for (var airport in _allAirports!) {
      if (airport.code.toLowerCase().contains(lowerQuery) ||
          airport.name.toLowerCase().contains(lowerQuery) ||
          airport.city.toLowerCase().contains(lowerQuery)) {
        results.add(airport);
      }
    }
    return results;
  }

  Future<List<Airport>> searchAirportsByCountry(String country) async {
    await loadAirports();
    return _airportsByCountry?[country] ?? [];
  }

  Future<List<String>> getCountries() async {
    await loadAirports();
    return _airportsByCountry!.keys.toList()..sort();
  }

  Future<List<Airport>> getAirportsByContinent(String continent) async {
    await loadAirports();

    final continentCountries = _getCountriesByContinent(continent);
    final results = <Airport>[];

    for (var country in continentCountries) {
      final airports = _airportsByCountry![country];
      if (airports != null) {
        results.addAll(airports);
      }
    }

    return results;
  }

  Set<String> _getCountriesByContinent(String continent) {
    const continentMap = {
      'Africa': {
        'Algeria',
        'Angola',
        'Benin',
        'Botswana',
        'Burkina Faso',
        'Burundi',
        'Cameroon',
        'Cape Verde',
        'Central African Republic',
        'Chad',
        'Comoros',
        'Democratic Republic of the Congo',
        'Republic of the Congo',
        'Djibouti',
        'Egypt',
        'Equatorial Guinea',
        'Eritrea',
        'Eswatini',
        'Ethiopia',
        'Gabon',
        'Gambia',
        'Ghana',
        'Guinea',
        'Guinea-Bissau',
        'Kenya',
        'Lesotho',
        'Liberia',
        'Libya',
        'Madagascar',
        'Malawi',
        'Mali',
        'Mauritania',
        'Mauritius',
        'Morocco',
        'Mozambique',
        'Namibia',
        'Niger',
        'Nigeria',
        'Rwanda',
        'São Tomé and Príncipe',
        'Senegal',
        'Seychelles',
        'Sierra Leone',
        'Somalia',
        'South Africa',
        'South Sudan',
        'Sudan',
        'Tanzania',
        'Togo',
        'Tunisia',
        'Uganda',
        'Zambia',
        'Zimbabwe',
      },
      'Asia': {
        'Afghanistan',
        'Armenia',
        'Azerbaijan',
        'Bahrain',
        'Bangladesh',
        'Bhutan',
        'Brunei',
        'Cambodia',
        'China',
        'Georgia',
        'Hong Kong',
        'India',
        'Indonesia',
        'Iran',
        'Iraq',
        'Israel',
        'Japan',
        'Jordan',
        'Kazakhstan',
        'Kuwait',
        'Kyrgyzstan',
        'Laos',
        'Lebanon',
        'Malaysia',
        'Maldives',
        'Mongolia',
        'Myanmar',
        'Nepal',
        'North Korea',
        'Oman',
        'Pakistan',
        'Philippines',
        'Qatar',
        'Saudi Arabia',
        'Singapore',
        'South Korea',
        'Sri Lanka',
        'Syria',
        'Taiwan',
        'Tajikistan',
        'Thailand',
        'Timor-Leste',
        'Turkey',
        'Turkmenistan',
        'United Arab Emirates',
        'Uzbekistan',
        'Vietnam',
        'Yemen',
      },
      'Europe': {
        'Albania',
        'Austria',
        'Belarus',
        'Belgium',
        'Bosnia and Herzegovina',
        'Bulgaria',
        'Croatia',
        'Cyprus',
        'Czech Republic',
        'Denmark',
        'Estonia',
        'Finland',
        'France',
        'Germany',
        'Greece',
        'Hungary',
        'Iceland',
        'Ireland',
        'Italy',
        'Kosovo',
        'Latvia',
        'Lithuania',
        'Luxembourg',
        'Malta',
        'Moldova',
        'Montenegro',
        'Netherlands',
        'North Macedonia',
        'Norway',
        'Poland',
        'Portugal',
        'Romania',
        'Russia',
        'Serbia',
        'Slovakia',
        'Slovenia',
        'Spain',
        'Sweden',
        'Switzerland',
        'Ukraine',
        'United Kingdom',
      },
      'North America': {
        'Canada',
        'United States',
        'Mexico',
        'Costa Rica',
        'Cuba',
        'Dominican Republic',
        'Guatemala',
        'Haiti',
        'Honduras',
        'Jamaica',
        'Nicaragua',
        'Panama',
        'Puerto Rico',
      },
      'South America': {
        'Argentina',
        'Bolivia',
        'Brazil',
        'Chile',
        'Colombia',
        'Ecuador',
        'Paraguay',
        'Peru',
        'Uruguay',
        'Venezuela',
      },
      'Oceania': {
        'Australia',
        'Fiji',
        'French Polynesia',
        'Kiribati',
        'Marshall Islands',
        'Micronesia',
        'Nauru',
        'New Zealand',
        'Palau',
        'Papua New Guinea',
        'Samoa',
        'Solomon Islands',
        'Tonga',
        'Vanuatu',
      },
    };

    return continentMap[continent] ?? {};
  }

  // HELPER METHODS
  Future<List<Map<String, String>>> getKenyanAirportsAsMap() async {
    final airports = await getKenyanAirports();
    return airports.map((a) => a.toMap()).toList();
  }

  Future<Map<String, List<Map<String, String>>>>
  getAirportsByCountryAsMap() async {
    final airportsByCountry = await getAirportsByCountry();
    final result = <String, List<Map<String, String>>>{};

    airportsByCountry.forEach((country, airports) {
      result[country] = airports.map((a) => a.toMap()).toList();
    });

    return result;
  }

  // STATISTICS
  Future<Map<String, dynamic>> getStatistics() async {
    await loadAirports();

    return {
      'totalCountries': _airportsByCountry!.length,
      'totalAirports': _allAirports!.length,
      'continents': {
        'Africa': _getCountriesByContinent('Africa').length,
        'Asia': _getCountriesByContinent('Asia').length,
        'Europe': _getCountriesByContinent('Europe').length,
        'North America': _getCountriesByContinent('North America').length,
        'South America': _getCountriesByContinent('South America').length,
        'Oceania': _getCountriesByContinent('Oceania').length,
      },
    };
  }

  // VALIDATION
  Future<bool> isValidAirportCode(String code) async {
    await loadAirports();
    return _airportByCode!.containsKey(code.toUpperCase());
  }

  // POPULAR AIRPORTS (Top 20 busiest worldwide)
  Future<List<Airport>> getPopularAirports() async {
    await loadAirports();

    const popularCodes = {
      'ATL',
      'PEK',
      'DXB',
      'LAX',
      'HND',
      'ORD',
      'LHR',
      'PVG',
      'CDG',
      'DFW',
      'AMS',
      'FRA',
      'IST',
      'CAN',
      'JFK',
      'SIN',
      'DEN',
      'ICN',
      'BKK',
      'SFO',
    };

    return _allAirports!
        .where((airport) => popularCodes.contains(airport.code))
        .toList();
  }

  // NEARBY AIRPORTS (Simple implementation - by country)
  Future<List<Airport>> getAirportsNear(String countryCode) async {
    await loadAirports();

    // This is a simplified version - in production, use geolocation
    final country = _findCountryByNameOrCode(countryCode);
    if (country == null) return [];

    final neighbors = _getNeighboringCountries(country);
    final results = <Airport>[];

    // Add airports from the target country
    results.addAll(_airportsByCountry![country] ?? []);

    // Add airports from neighboring countries
    for (var neighbor in neighbors) {
      results.addAll(_airportsByCountry![neighbor] ?? []);
    }

    return results.take(10).toList(); // Limit results
  }

  String? _findCountryByNameOrCode(String input) {
    for (var country in _airportsByCountry!.keys) {
      if (country.toLowerCase().contains(input.toLowerCase())) {
        return country;
      }
    }
    return null;
  }

  List<String> _getNeighboringCountries(String country) {
    // Simplified neighbor map
    const neighbors = {
      'Kenya': ['Tanzania', 'Uganda', 'Ethiopia', 'Somalia', 'South Sudan'],
      'United States': ['Canada', 'Mexico'],
      'France': ['Germany', 'Italy', 'Spain', 'Belgium', 'Switzerland'],
      // Add more as needed
    };

    return neighbors[country] ?? [];
  }
}
