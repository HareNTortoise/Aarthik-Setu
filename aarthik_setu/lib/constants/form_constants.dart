class IndiaStates {
  // Union Territories
  static const String andamanAndNicobarIslands = "Andaman and Nicobar Islands (union territory)";
  static const String chandigarh = "Chandigarh (union territory)";
  static const String dadraAndNagarHaveliAndDamanAndDiu = "Dadra and Nagar Haveli and Daman and Diu (union territory)";
  static const String delhi = "Delhi (national capital territory)";
  static const String jammuAndKashmir = "Jammu and Kashmir (union territory)";
  static const String ladakh = "Ladakh (union territory)";
  static const String puducherry = "Puducherry (union territory)";

  // States
  static const String andhraPradesh = "Andhra Pradesh";
  static const String arunachalPradesh = "Arunachal Pradesh";
  static const String assam = "Assam";
  static const String bihar = "Bihar";
  static const String chhattisgarh = "Chhattisgarh";
  static const String goa = "Goa";
  static const String gujarat = "Gujarat";
  static const String haryana = "Haryana";
  static const String himachalPradesh = "Himachal Pradesh";
  static const String jharkhand = "Jharkhand";
  static const String karnataka = "Karnataka";
  static const String kerala = "Kerala";
  static const String madhyaPradesh = "Madhya Pradesh";
  static const String maharashtra = "Maharashtra";
  static const String manipur = "Manipur";
  static const String meghalaya = "Meghalaya";
  static const String mizoram = "Mizoram";
  static const String nagaland = "Nagaland";
  static const String odisha = "Odisha";
  static const String punjab = "Punjab";
  static const String rajasthan = "Rajasthan";
  static const String sikkim = "Sikkim";
  static const String tamilNadu = "Tamil Nadu";
  static const String telangana = "Telangana";
  static const String tripura = "Tripura";
  static const String uttarPradesh = "Uttar Pradesh";
  static const String uttarakhand = "Uttarakhand";
  static const String westBengal = "West Bengal";

  static List<String> getAllStatesAndUTs() {
    return [
      // Union Territories
      andamanAndNicobarIslands,
      chandigarh,
      dadraAndNagarHaveliAndDamanAndDiu,
      delhi,
      jammuAndKashmir,
      ladakh,
      puducherry,

      // States
      andhraPradesh,
      arunachalPradesh,
      assam,
      bihar,
      chhattisgarh,
      goa,
      gujarat,
      haryana,
      himachalPradesh,
      jharkhand,
      karnataka,
      kerala,
      madhyaPradesh,
      maharashtra,
      manipur,
      meghalaya,
      mizoram,
      nagaland,
      odisha,
      punjab,
      rajasthan,
      sikkim,
      tamilNadu,
      telangana,
      tripura,
      uttarPradesh,
      uttarakhand,
      westBengal,
    ];
  }
}

class IndiaCities {
  static const citiesMap = {
    "Andaman and Nicobar Islands": ["Port Blair"],
    "Andhra Pradesh": [
      "Adoni",
      "Amaravati",
      "Anantapur",
      "Chandragiri",
      "Chittoor",
      "Dowlaiswaram",
      "Eluru",
      "Guntur",
      "Kadapa",
      "Kakinada",
      "Kurnool",
      "Machilipatnam",
      "Nagarjunakoṇḍa",
      "Rajahmundry",
      "Srikakulam",
      "Tirupati",
      "Vijayawada",
      "Visakhapatnam",
      "Vizianagaram",
      "Yemmiganur"
    ],
    "Arunachal Pradesh": ["Itanagar"],
    "Assam": [
      "Dhuburi",
      "Dibrugarh",
      "Dispur",
      "Guwahati",
      "Jorhat",
      "Nagaon",
      "Sivasagar",
      "Silchar",
      "Tezpur",
      "Tinsukia"
    ],
    "Bihar": [
      "Ara",
      "Barauni",
      "Begusarai",
      "Bettiah",
      "Bhagalpur",
      "Bihar Sharif",
      "Bodh Gaya",
      "Buxar",
      "Chapra",
      "Darbhanga",
      "Dehri",
      "Dinapur Nizamat",
      "Gaya",
      "Hajipur",
      "Jamalpur",
      "Katihar",
      "Madhubani",
      "Motihari",
      "Munger",
      "Muzaffarpur",
      "Patna",
      "Purnia",
      "Pusa",
      "Saharsa",
      "Samastipur",
      "Sasaram",
      "Sitamarhi",
      "Siwan"
    ],
    "Chandigarh": ["Chandigarh"],
    "Chhattisgarh": ["Ambikapur", "Bhilai", "Bilaspur", "Dhamtari", "Durg", "Jagdalpur", "Raipur", "Rajnandgaon"],
    "Dadra and Nagar Haveli and Daman and Diu": ["Daman", "Diu", "Silvassa"],
    "Delhi": ["Delhi", "New Delhi"],
    "Goa": ["Madgaon", "Panaji"],
    "Gujarat": [
      "Ahmadabad",
      "Amreli",
      "Bharuch",
      "Bhavnagar",
      "Bhuj",
      "Dwarka",
      "Gandhinagar",
      "Godhra",
      "Jamnagar",
      "Junagadh",
      "Kandla",
      "Khambhat",
      "Kheda",
      "Mahesana",
      "Morbi",
      "Nadiad",
      "Navsari",
      "Okha",
      "Palanpur",
      "Patan",
      "Porbandar",
      "Rajkot",
      "Surat",
      "Surendranagar",
      "Valsad",
      "Veraval"
    ],
    "Haryana": [
      "Ambala",
      "Bhiwani",
      "Chandigarh",
      "Faridabad",
      "Firozpur Jhirka",
      "Gurugram",
      "Hansi",
      "Hisar",
      "Jind",
      "Kaithal",
      "Karnal",
      "Kurukshetra",
      "Panipat",
      "Pehowa",
      "Rewari",
      "Rohtak",
      "Sirsa",
      "Sonipat"
    ],
    "Himachal Pradesh": [
      "Bilaspur",
      "Chamba",
      "Dalhousie",
      "Dharmshala",
      "Hamirpur",
      "Kangra",
      "Kullu",
      "Mandi",
      "Nahan",
      "Shimla",
      "Una"
    ],
    "Jammu and Kashmir": [
      "Anantnag",
      "Baramula",
      "Doda",
      "Gulmarg",
      "Jammu",
      "Kathua",
      "Punch",
      "Rajouri",
      "Srinagar",
      "Udhampur"
    ],
    "Jharkhand": [
      "Bokaro",
      "Chaibasa",
      "Deoghar",
      "Dhanbad",
      "Dumka",
      "Giridih",
      "Hazaribag",
      "Jamshedpur",
      "Jharia",
      "Rajmahal",
      "Ranchi",
      "Saraikela"
    ],
    "Karnataka": [
      "Badami",
      "Ballari",
      "Bengaluru",
      "Belagavi",
      "Bhadravati",
      "Bidar",
      "Chikkamagaluru",
      "Chitradurga",
      "Davangere",
      "Halebid",
      "Hassan",
      "Hubballi-Dharwad",
      "Kalaburagi",
      "Kolar",
      "Madikeri",
      "Mandya",
      "Mangaluru",
      "Mysuru",
      "Raichur",
      "Shivamogga",
      "Shravanabelagola",
      "Shrirangapattana",
      "Tumakuru",
      "Vijayapura"
    ],
    "Kerala": [
      "Alappuzha",
      "Vatakara",
      "Idukki",
      "Kannur",
      "Kochi",
      "Kollam",
      "Kottayam",
      "Kozhikode",
      "Mattancheri",
      "Palakkad",
      "Thalassery",
      "Thiruvananthapuram",
      "Thrissur"
    ],
    "Ladakh": ["Kargil", "Leh"],
    "Madhya Pradesh": [
      "Balaghat",
      "Barwani",
      "Betul",
      "Bharhut",
      "Bhind",
      "Bhojpur",
      "Bhopal",
      "Burhanpur",
      "Chhatarpur",
      "Chhindwara",
      "Damoh",
      "Datia",
      "Dewas",
      "Dhar",
      "Dr. Ambedkar Nagar (Mhow)",
      "Guna",
      "Gwalior",
      "Hoshangabad",
      "Indore",
      "Itarsi",
      "Jabalpur",
      "Jhabua",
      "Khajuraho",
      "Khandwa",
      "Khargone",
      "Maheshwar",
      "Mandla",
      "Mandsaur",
      "Morena",
      "Murwara",
      "Narsimhapur",
      "Narsinghgarh",
      "Narwar",
      "Neemuch",
      "Nowgong",
      "Orchha",
      "Panna",
      "Raisen",
      "Rajgarh",
      "Ratlam",
      "Rewa",
      "Sagar",
      "Sarangpur",
      "Satna",
      "Sehore",
      "Seoni",
      "Shahdol",
      "Shajapur",
      "Sheopur",
      "Shivpuri",
      "Ujjain",
      "Vidisha"
    ],
    "Maharashtra": [
      "Ahmadnagar",
      "Akola",
      "Amravati",
      "Aurangabad",
      "Bhandara",
      "Bhusawal",
      "Bid",
      "Buldhana",
      "Chandrapur",
      "Daulatabad",
      "Dhule",
      "Jalgaon",
      "Kalyan",
      "Karli",
      "Kolhapur",
      "Mahabaleshwar",
      "Malegaon",
      "Matheran",
      "Mumbai",
      "Nagpur",
      "Nanded",
      "Nashik",
      "Osmanabad",
      "Pandharpur",
      "Parbhani",
      "Pune",
      "Ratnagiri",
      "Sangli",
      "Satara",
      "Sevagram",
      "Solapur",
      "Thane",
      "Ulhasnagar",
      "Vasai-Virar",
      "Wardha",
      "Yavatmal"
    ],
    "Manipur": ["Imphal"],
    "Meghalaya": ["Cherrapunji", "Shillong"],
    "Mizoram": ["Aizawl", "Lunglei"],
    "Nagaland": ["Kohima", "Mon", "Phek", "Wokha", "Zunheboto"],
    "Odisha": [
      "Balangir",
      "Baleshwar",
      "Baripada",
      "Bhubaneshwar",
      "Brahmapur",
      "Cuttack",
      "Dhenkanal",
      "Kendujhar",
      "Konark",
      "Koraput",
      "Paradip",
      "Phulabani",
      "Puri",
      "Sambalpur",
      "Udayagiri"
    ],
    "Puducherry": ["Karaikal", "Mahe", "Puducherry", "Yanam"],
    "Punjab": [
      "Amritsar",
      "Batala",
      "Chandigarh",
      "Faridkot",
      "Firozpur",
      "Gurdaspur",
      "Hoshiarpur",
      "Jalandhar",
      "Kapurthala",
      "Ludhiana",
      "Nabha",
      "Patiala",
      "Rupnagar",
      "Sangrur"
    ],
    "Rajasthan": [
      "Abu",
      "Ajmer",
      "Alwar",
      "Amer",
      "Barmer",
      "Beawar",
      "Bharatpur",
      "Bhilwara",
      "Bikaner",
      "Bundi",
      "Chittaurgarh",
      "Churu",
      "Dhaulpur",
      "Dungarpur",
      "Ganganagar",
      "Hanumangarh",
      "Jaipur",
      "Jaisalmer",
      "Jalor",
      "Jhalawar",
      "Jhunjhunu",
      "Jodhpur",
      "Kishangarh",
      "Kota",
      "Merta",
      "Nagaur",
      "Nathdwara",
      "Pali",
      "Phalodi",
      "Pushkar",
      "Sawai Madhopur",
      "Shahpura",
      "Sikar",
      "Sirohi",
      "Tonk",
      "Udaipur"
    ],
    "Sikkim": ["Gangtok"],
    "Tamil Nadu": [
      "Chennai",
      "Coimbatore",
      "Cuddalore",
      "Dharmapuri",
      "Dindigul",
      "Erode",
      "Kanchipuram",
      "Kanniyakumari",
      "Kodaikanal",
      "Kumbakonam",
      "Madurai",
      "Mamallapuram",
      "Nagappattinam",
      "Nagercoil",
      "Palani",
      "Pudukkottai",
      "Rajapalayam",
      "Ramanathapuram",
      "Salem",
      "Thanjavur",
      "Tiruchirappalli",
      "Tirunelveli",
      "Tuticorin",
      "Udhagamandalam",
      "Vellore"
    ],
    "Telangana": ["Hyderabad", "Karimnagar", "Khammam", "Mahbubnagar", "Nizamabad", "Sangareddi", "Warangal"],
    "Tripura": ["Agartala"],
    "Uttar Pradesh": [
      "Agra",
      "Aligarh",
      "Amroha",
      "Ayodhya",
      "Azamgarh",
      "Bahraich",
      "Ballia",
      "Banda",
      "Bara Banki",
      "Bareilly",
      "Basti",
      "Bijnor",
      "Bithur",
      "Bulandshahr",
      "Deoria",
      "Etawah",
      "Faizabad",
      "Farrukhabad-cum-Fatehgarh",
      "Fatehpur",
      "Fatehpur Sikri",
      "Ghaziabad",
      "Ghazipur",
      "Gonda",
      "Gorakhpur",
      "Hamirpur",
      "Hardoi",
      "Hathras",
      "Jaunpur",
      "Jhansi",
      "Kannauj",
      "Kanpur",
      "Lakhimpur",
      "Lalitpur",
      "Lucknow",
      "Mainpuri",
      "Mathura",
      "Meerut",
      "Mirzapur-Vindhyachal",
      "Moradabad",
      "Muzaffarnagar",
      "Partapgarh",
      "Pilibhit",
      "Prayagraj",
      "Raebareli",
      "Rampur",
      "Saharanpur",
      "Sambhal",
      "Shahjahanpur",
      "Sitapur",
      "Sultanpur",
      "Varanasi"
    ],
    "Uttarakhand": [
      "Almora",
      "Dehra Dun",
      "Haridwar",
      "Mussoorie",
      "Nainital",
      "Pithoragarh",
      "Ranikhet",
      "Rishikesh",
      "Roorkee"
    ],
    "West Bengal": [
      "Alipore",
      "Alipur Duar",
      "Asansol",
      "Baharampur",
      "Bally",
      "Balurghat",
      "Bankura",
      "Baranagar",
      "Barasat",
      "Barrackpore",
      "Basirhat",
      "Bhatpara",
      "Bishnupur",
      "Budge Budge",
      "Burdwan",
      "Chandernagore",
      "Darjiling",
      "Diamond Harbour",
      "Dum Dum",
      "Durgapur",
      "Haldia",
      "Haora",
      "Hugli",
      "Ingraj Bazar",
      "Jalpaiguri",
      "Kalimpong",
      "Kamarhati",
      "Kanchrapara",
      "Kharagpur",
      "Kolkata",
      "Krishnanagar",
      "Malda",
      "Murshidabad",
      "Nabadwip",
      "Palashi",
      "Purulia",
      "Raiganj",
      "Santipur",
      "Shantiniketan",
      "Shrirampur",
      "Siliguri"
    ]
  };
}

class Countries {
  static const List<String> countryList = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cabo Verde",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo (Congo-Brazzaville)",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Democratic Republic of the Congo",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "East Timor (Timor-Leste)",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar (Burma)",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Korea",
    "North Macedonia",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Korea",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];
}

class Genders {
  static const male = 'Male';
  static const female = 'Female';
  static const other = 'Other';

  static List<String> getGenders() {
    return [male, female, other];
  }
}

class Categories {
  static const String general = 'General';
  static const String obc = 'OBC';
  static const String sc = 'SC';
  static const String st = 'ST';
  static const String others = 'Others';

  static List<String> getCategories() {
    return [general, obc, sc, st, others];
  }
}

class MaritalStatus {
  static const String single = 'Single';
  static const String married = 'Married';
  static const String divorced = 'Divorced';
  static const String widowed = 'Widowed';

  static List<String> getMaritalStatuses() {
    return [single, married, divorced, widowed];
  }
}

class EducationQualifications {
  static const String diploma = 'Diploma';
  static const String undergraduate = 'Undergraduate';
  static const String graduate = 'Graduate';
  static const String postGraduate = 'Post Graduate';
  static const String doctorate = 'Doctorate';
  static const String others = 'Others';

  static List<String> getEducationQualifications() {
    return [diploma, undergraduate, graduate, postGraduate, doctorate, others];
  }
}

class Nationalities {
  static const String resident = 'Resident';
  static const String nonResident = 'Non-Resident';

  static List<String> getNationalities() {
    return [resident, nonResident];
  }
}

class Salutations {
  static const String mr = 'Mr.';
  static const String mrs = 'Mrs.';
  static const String ms = 'Ms.';
  static const String dr = 'Dr.';
  static const String prof = 'Prof.';
  static const String other = 'Other';

  static List<String> getSalutations() {
    return [mr, mrs, ms, dr, prof, other];
  }
}

class Dependents {
  static const String zero = '0';
  static const String one = '1';
  static const String two = '2';
  static const String three = '3';
  static const String four = '4';
  static const String five = '5';
  static const String six = '6';
  static const String seven = '7';
  static const String eight = '8';
  static const String nine = '9';
  static const String ten = '10';

  static List<String> getDependents() {
    return [zero, one, two, three, four, five, six, seven, eight, nine, ten];
  }
}

class EmploymentType {
  static const String salaried = 'Salaried';
  static const String selfEmployed = 'Self Employed';
  static const String business = 'Business';
  static const String student = 'Student';
  static const String retired = 'Retired';
  static const String unemployed = 'Unemployed';
  static const String others = 'Others';

  static List<String> getEmploymentTypes() {
    return [salaried, selfEmployed, business, student, retired, unemployed, others];
  }
}

class EmploymentStatus {
  static const String regular = 'Regular';
  static const String probationary = 'Probationary';
  static const String contractual = 'Contractual';

  static List<String> getEmploymentStatuses() {
    return [regular, probationary, contractual];
  }
}

class Designations {
  static const String seniorManagement = 'Senior Management';
  static const String middleManagement = 'Middle Management';
  static const String junior = 'Junior';
  static const String selfEmployed = 'Self Employed';
  static const String pensioner = 'Pensioner';
  static const String others = 'Others';

  static List<String> getDesignations() {
    return [seniorManagement, middleManagement, junior, selfEmployed, pensioner, others];
  }
}

class ModesOfSalary {
  static const String cash = 'Cash';
  static const String cheque = 'Cheque';
  static const String directInAccount = 'Direct in Account';

  static List<String> getModesOfSalary() {
    return [cash, cheque, directInAccount];
  }
}


class LoanTypes{
  static const String personal = 'Personal';
  static const String home = 'Home';
  static const String creditCard = 'Credit Card';
  static const String vehicle = 'Vehicle';
  static const String education = 'Education';
  static const String business = 'Business';
  static const String others = 'Others';

  static List<String> getLoanTypes() {
    return [personal, home, creditCard, vehicle, education, business, others];
  }
}

class TypesOfResidence {
  static const String own = 'Own';
  static const String rented = 'Rented';
  static const String companyProvided = 'Company Provided';
  static const String parentOwned = 'Parent Owned';
  static const String spouseOwned = 'Spouse Owned';
  static const String other = 'Other';

  static List<String> getTypesOfResidence() {
    return [own, rented, companyProvided, parentOwned, spouseOwned, other];
  }
}

class RepaymentMethods {
  static const String emi = 'EMI';
  static const String bullet = 'Bullet';
  static const String overdraft = 'Overdraft';
  static const String others = 'Others';

  static List<String> getRepaymentModes() {
    return [emi, bullet, overdraft, others];
  }
}