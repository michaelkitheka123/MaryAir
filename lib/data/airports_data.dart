import '../models/airport_model.dart';

final Map<String, List<Airport>> airportsByCountry = {
  // AFRICA
  'Algeria': [
    Airport(code: 'ALG', name: 'Houari Boumediene Airport', city: 'Algiers'),
    Airport(code: 'ORN', name: 'Oran Es Sénia Airport', city: 'Oran'),
    Airport(code: 'AAE', name: 'Rabah Bitat Airport', city: 'Annaba'),
    Airport(
      code: 'CZL',
      name: 'Mohamed Boudiaf International',
      city: 'Constantine',
    ),
  ],
  'Angola': [
    Airport(code: 'LAD', name: 'Quatro de Fevereiro Airport', city: 'Luanda'),
    Airport(code: 'SDD', name: 'Lubango Airport', city: 'Lubango'),
    Airport(code: 'NOV', name: 'Albano Machado Airport', city: 'Huambo'),
  ],
  'Benin': [Airport(code: 'COO', name: 'Cadjehoun Airport', city: 'Cotonou')],
  'Botswana': [
    Airport(
      code: 'GBE',
      name: 'Sir Seretse Khama International',
      city: 'Gaborone',
    ),
    Airport(code: 'MUB', name: 'Maun Airport', city: 'Maun'),
    Airport(code: 'FRW', name: 'Francistown Airport', city: 'Francistown'),
  ],
  'Burkina Faso': [
    Airport(code: 'OUA', name: 'Ouagadougou Airport', city: 'Ouagadougou'),
    Airport(
      code: 'BOY',
      name: 'Bobo Dioulasso Airport',
      city: 'Bobo-Dioulasso',
    ),
  ],
  'Burundi': [
    Airport(code: 'BJM', name: 'Bujumbura International', city: 'Bujumbura'),
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
    Airport(code: 'RAI', name: 'Nelson Mandela International', city: 'Praia'),
    Airport(code: 'SID', name: 'Amílcar Cabral International', city: 'Sal'),
  ],
  'Central African Republic': [
    Airport(code: 'BGF', name: 'Bangui M\'Poko International', city: 'Bangui'),
  ],
  'Chad': [
    Airport(code: 'NDJ', name: 'N\'Djamena International', city: 'N\'Djamena'),
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
    Airport(code: 'FBM', name: 'Lubumbashi International', city: 'Lubumbashi'),
    Airport(code: 'GOM', name: 'Goma International', city: 'Goma'),
  ],
  'Republic of the Congo': [
    Airport(code: 'BZV', name: 'Maya-Maya Airport', city: 'Brazzaville'),
    Airport(
      code: 'PNR',
      name: 'Agostinho-Neto International',
      city: 'Pointe-Noire',
    ),
  ],
  "Côte d'Ivoire": [
    Airport(code: 'ABJ', name: 'Port Bouet Airport', city: 'Abidjan'),
    Airport(code: 'BYK', name: 'Bouaké Airport', city: 'Bouaké'),
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
    Airport(code: 'ALY', name: 'El Nouzha Airport', city: 'Alexandria'),
  ],
  'Equatorial Guinea': [
    Airport(code: 'SSG', name: 'Malabo International', city: 'Malabo'),
    Airport(code: 'BSG', name: 'Bata Airport', city: 'Bata'),
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
    Airport(code: 'DIR', name: 'Aba Tenna Dejazmach Yilma', city: 'Dire Dawa'),
    Airport(code: 'MQX', name: 'Mekele Airport', city: 'Mekele'),
  ],
  'Gabon': [
    Airport(code: 'LBV', name: 'Leon M\'ba International', city: 'Libreville'),
    Airport(
      code: 'POG',
      name: 'Port-Gentil International',
      city: 'Port-Gentil',
    ),
  ],
  'Gambia': [
    Airport(code: 'BJL', name: 'Banjul International', city: 'Banjul'),
  ],
  'Ghana': [
    Airport(code: 'ACC', name: 'Kotoka International', city: 'Accra'),
    Airport(code: 'KMS', name: 'Kumasi Airport', city: 'Kumasi'),
    Airport(code: 'TML', name: 'Tamale Airport', city: 'Tamale'),
  ],
  'Guinea': [
    Airport(code: 'CKY', name: 'Conakry International', city: 'Conakry'),
  ],
  'Guinea-Bissau': [
    Airport(code: 'OXB', name: 'Osvaldo Vieira International', city: 'Bissau'),
  ],
  'Kenya': [
    Airport(code: 'NBO', name: 'Jomo Kenyatta International', city: 'Nairobi'),
    Airport(code: 'MBA', name: 'Moi International', city: 'Mombasa'),
    Airport(code: 'KIS', name: 'Kisumu International', city: 'Kisumu'),
    Airport(code: 'WIL', name: 'Wilson Airport', city: 'Nairobi'),
    Airport(code: 'MYD', name: 'Malindi Airport', city: 'Malindi'),
    Airport(code: 'UKA', name: 'Ukunda Airstrip', city: 'Ukunda'),
  ],
  'Lesotho': [
    Airport(code: 'MSU', name: 'Moshoeshoe I International', city: 'Maseru'),
  ],
  'Liberia': [
    Airport(code: 'ROB', name: 'Roberts International', city: 'Monrovia'),
  ],
  'Libya': [
    Airport(code: 'TIP', name: 'Tripoli International', city: 'Tripoli'),
    Airport(code: 'BEN', name: 'Benina International', city: 'Benghazi'),
  ],
  'Madagascar': [
    Airport(code: 'TNR', name: 'Ivato International', city: 'Antananarivo'),
    Airport(code: 'NOS', name: 'Fascene Airport', city: 'Nosy Be'),
  ],
  'Malawi': [
    Airport(code: 'LLW', name: 'Lilongwe International', city: 'Lilongwe'),
    Airport(code: 'BLZ', name: 'Chileka International', city: 'Blantyre'),
  ],
  'Mali': [Airport(code: 'BKO', name: 'Senou International', city: 'Bamako')],
  'Mauritania': [
    Airport(
      code: 'NKC',
      name: 'Nouakchott–Oumtounsy International',
      city: 'Nouakchott',
    ),
    Airport(code: 'ATR', name: 'Atar International', city: 'Atar'),
  ],
  'Mauritius': [
    Airport(
      code: 'MRU',
      name: 'Sir Seewoosagur Ramgoolam International',
      city: 'Plaine Magnien',
    ),
    Airport(
      code: 'RRG',
      name: 'Sir Charles Gaetan Duval Airport',
      city: 'Rodrigues Island',
    ),
  ],
  'Morocco': [
    Airport(code: 'CMN', name: 'Mohammed V International', city: 'Casablanca'),
    Airport(code: 'RAK', name: 'Menara Airport', city: 'Marrakech'),
    Airport(code: 'FEZ', name: 'Fès–Saïs Airport', city: 'Fez'),
    Airport(code: 'AGA', name: 'Al Massira Airport', city: 'Agadir'),
    Airport(code: 'TNG', name: 'Ibn Batouta Airport', city: 'Tangier'),
  ],
  'Mozambique': [
    Airport(code: 'MPM', name: 'Maputo International', city: 'Maputo'),
    Airport(code: 'BEW', name: 'Beira Airport', city: 'Beira'),
    Airport(code: 'APL', name: 'Nampula Airport', city: 'Nampula'),
  ],
  'Namibia': [
    Airport(code: 'WDH', name: 'Hosea Kutako International', city: 'Windhoek'),
    Airport(code: 'WVB', name: 'Walvis Bay Airport', city: 'Walvis Bay'),
  ],
  'Niger': [
    Airport(code: 'NIM', name: 'Diori Hamani International', city: 'Niamey'),
  ],
  'Nigeria': [
    Airport(code: 'LOS', name: 'Murtala Muhammed International', city: 'Lagos'),
    Airport(code: 'ABV', name: 'Nnamdi Azikiwe International', city: 'Abuja'),
    Airport(code: 'KAN', name: 'Mallam Aminu International', city: 'Kano'),
    Airport(
      code: 'PHC',
      name: 'Port Harcourt International',
      city: 'Port Harcourt',
    ),
    Airport(code: 'ENU', name: 'Akanu Ibiam International', city: 'Enugu'),
  ],
  'Rwanda': [
    Airport(code: 'KGL', name: 'Kigali International', city: 'Kigali'),
  ],
  'São Tomé and Príncipe': [
    Airport(code: 'TMS', name: 'São Tomé International', city: 'São Tomé'),
  ],
  'Senegal': [
    Airport(code: 'DKR', name: 'Blaise Diagne International', city: 'Dakar'),
    Airport(
      code: 'DSS',
      name: 'Léopold Sédar Senghor International',
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
    Airport(code: 'MGQ', name: 'Aden Adde International', city: 'Mogadishu'),
    Airport(code: 'HGA', name: 'Egal International', city: 'Hargeisa'),
  ],
  'South Africa': [
    Airport(
      code: 'JNB',
      name: 'O. R. Tambo International',
      city: 'Johannesburg',
    ),
    Airport(code: 'CPT', name: 'Cape Town International', city: 'Cape Town'),
    Airport(code: 'DUR', name: 'King Shaka International', city: 'Durban'),
    Airport(code: 'GRJ', name: 'George Airport', city: 'George'),
    Airport(
      code: 'PLZ',
      name: 'Port Elizabeth International',
      city: 'Port Elizabeth',
    ),
  ],
  'South Sudan': [
    Airport(code: 'JUB', name: 'Juba International', city: 'Juba'),
  ],
  'Sudan': [
    Airport(code: 'KRT', name: 'Khartoum International', city: 'Khartoum'),
    Airport(
      code: 'PZU',
      name: 'Port Sudan New International',
      city: 'Port Sudan',
    ),
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
    Airport(code: 'ARK', name: 'Arusha Airport', city: 'Arusha'),
    Airport(code: 'MWZ', name: 'Mwanza Airport', city: 'Mwanza'),
  ],
  'Togo': [
    Airport(code: 'LFW', name: 'Lomé–Tokoin International', city: 'Lomé'),
  ],
  'Tunisia': [
    Airport(code: 'TUN', name: 'Tunis–Carthage International', city: 'Tunis'),
    Airport(
      code: 'MIR',
      name: 'Monastir Habib Bourguiba International',
      city: 'Monastir',
    ),
    Airport(code: 'SFA', name: 'Sfax–Thyna International', city: 'Sfax'),
    Airport(code: 'DJE', name: 'Djerba–Zarzis International', city: 'Djerba'),
  ],
  'Uganda': [
    Airport(code: 'EBB', name: 'Entebbe International', city: 'Entebbe'),
    Airport(code: 'KSE', name: 'Kasese Airport', city: 'Kasese'),
  ],
  'Zambia': [
    Airport(code: 'LUN', name: 'Kenneth Kaunda International', city: 'Lusaka'),
    Airport(
      code: 'NLA',
      name: 'Simon Mwansa Kapwepwe International',
      city: 'Ndola',
    ),
    Airport(
      code: 'LVI',
      name: 'Harry Mwanga Nkumbula International',
      city: 'Livingstone',
    ),
  ],
  'Zimbabwe': [
    Airport(
      code: 'HRE',
      name: 'Robert Gabriel Mugabe International',
      city: 'Harare',
    ),
    Airport(
      code: 'BUQ',
      name: 'Joshua Mqabuko Nkomo International',
      city: 'Bulawayo',
    ),
    Airport(
      code: 'VFA',
      name: 'Victoria Falls International',
      city: 'Victoria Falls',
    ),
  ],
};
