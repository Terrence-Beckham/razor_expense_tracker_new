import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:transactions_api/transactions_api.dart';

///Todo This needs to become a list and then stored in a Repo
///User categories will be stored here as well.
final business = StoredCategory()
  ..name = 'Business'
  ..iconName = 'business'
  ..colorName = 'yellow';
final mortgage = StoredCategory()
  ..name = 'Mortgage'
  ..iconName = 'mortgage'
  ..colorName = 'blue';
final vacations = StoredCategory()
  ..name = 'Vacations'
  ..iconName = 'vacations'
  ..colorName = 'white';
final movies = StoredCategory()
  ..name = 'Movies'
  ..iconName = 'movies'
  ..colorName = 'green';
final games = StoredCategory()
  ..name = 'Games'
  ..iconName = 'games'
  ..colorName = 'cyan_accent';
final entertainment = StoredCategory()
  ..name = 'Entertainment'
  ..iconName = 'entertainment'
  ..colorName = 'orange';
final charity = StoredCategory()
  ..name = 'Charity'
  ..iconName = 'charity'
  ..colorName = 'pink';
final specialOccasion = StoredCategory()
  ..name = 'SpecialOccasion'
  ..iconName = 'special_occasion'
  ..colorName = 'purple';
final gifts = StoredCategory()
  ..name = 'Gifts'
  ..iconName = 'gifts'
  ..colorName = 'blue_grey';
final donations = StoredCategory()
  ..name = 'donations'
  ..iconName = 'donations'
  ..colorName = 'brown';
final transportation = StoredCategory()
  ..name = 'Transportation'
  ..iconName = 'transportation'
  ..colorName = 'blue_grey';
final investing = StoredCategory()
  ..name = 'Investing'
  ..iconName = 'investing'
  ..colorName = 'light_blue';
final food = StoredCategory()
  ..name = 'Food'
  ..iconName = 'food'
  ..colorName = 'blue_accent';
final groceries = StoredCategory()
  ..name = 'Groceries'
  ..iconName = 'groceries'
  ..colorName = 'indigo';
final restaurants = StoredCategory()
  ..name = 'Restaurants'
  ..iconName = 'retaurants'
  ..colorName = 'light_green';
final electricity = StoredCategory()
  ..name = 'Electricity'
  ..iconName = 'electricity'
  ..colorName = 'deep_orange';
final phone = StoredCategory()
  ..name = 'Phone'
  ..iconName = 'phone'
  ..colorName = 'grey';
final cable = StoredCategory()
  ..name = 'Cable'
  ..iconName = 'cable'
  ..colorName = 'red_accent';
final internet = StoredCategory()
  ..name = 'Internet'
  ..iconName = 'internet'
  ..colorName = 'cyan_accent';
final clothing = StoredCategory()
  ..name = 'Clothing'
  ..iconName = 'clothing'
  ..colorName = 'blue_grey';
final medical = StoredCategory()
  ..name = 'Medical'
  ..iconName = 'medical'
  ..colorName = 'deep_purple';
final dental = StoredCategory()
  ..name = 'Dental'
  ..iconName = 'dental'
  ..colorName = 'orange_accent';
final medications = StoredCategory()
  ..name = 'Medication'
  ..iconName = 'medications'
  ..colorName = 'deep_urple_accent';
final insurance = StoredCategory()
  ..name = 'Insurance'
  ..iconName = 'investing'
  ..colorName = 'green_accent';
final householdItems = StoredCategory()
  ..name = 'Household Items'
  ..iconName = 'household_items'
  ..colorName = 'brown';
final householdSupplies = StoredCategory()
  ..name = 'Household Supplies'
  ..iconName = 'household_supplies'
  ..colorName = 'pink';
final cleaningSupplies = StoredCategory()
  ..name = 'Cleaning Supplies'
  ..iconName = 'cleaning_supplies'
  ..colorName = 'red_accent';
final tools = StoredCategory()
  ..name = 'Tools'
  ..iconName = 'tools'
  ..colorName = 'brown';
final gymMembership = StoredCategory()
  ..name = 'Gym'
  ..iconName = 'exercise'
  ..colorName = 'deep_cyan';
final salon = StoredCategory()
  ..name = 'Salon'
  ..iconName = 'styler'
  ..colorName = 'orange';
final subscriptions = StoredCategory()
  ..name = 'Subscriptions'
  ..iconName = 'subscriptions'
  ..colorName = 'pink_accent';
final debt = StoredCategory()
  ..name = 'Debt'
  ..iconName = 'debt'
  ..colorName = 'light_blue';
final loans = StoredCategory()
  ..name = 'Loans'
  ..iconName = 'loans'
  ..colorName = 'blue_accent';
final credit = StoredCategory()
  ..name = 'Credit'
  ..iconName = 'credit'
  ..colorName = 'deep_orange';
final education = StoredCategory()
  ..name = 'Education'
  ..iconName = 'education'
  ..colorName = 'deep_purple_accent';

const myIcons = <String, IconData>{
  'exercise': Symbols.exercise,
  'styler': Symbols.styler,
  'subscriptions': Symbols.subscriptions,
  'debt': Symbols.credit_score,
  'loans': Symbols.real_estate_agent,
  'credit': Symbols.credit_card,
  'education': Symbols.school,
  'business': Symbols.storefront,
  'mortgage': Symbols.real_estate_agent,
  'vacations': Symbols.holiday_village,
  'movies': Symbols.theaters,
  'games': Symbols.toys_and_games,
  'entertainment': Symbols.attractions,
  'charity': Symbols.volunteer_activism,
  'specialOccasion': Symbols.special_character,
  'gifts': Symbols.featured_seasonal_and_gifts,
  'donations': Symbols.volunteer_activism,
  'transportation': Symbols.emoji_transportation,
  'investing': Symbols.finance_mode,
  'food': Symbols.fastfood,
  'groceries': Symbols.grocery,
  'restaurants': Symbols.restaurant,
  'electricity': Symbols.water_ec,
  'phone': Symbols.smartphone,
  'cable': Symbols.cable,
  'internet': Symbols.wifi,
  'clothing': Symbols.apparel,
  'medical': Symbols.medical_services,
  'dental': Symbols.dentistry,
  'medications': Symbols.medication_liquid,
  'householdItems': Symbols.flatware,
  'householdSupplies': Symbols.household_supplies,
  'cleaningSupplies': Symbols.cleaning_bucket,
  'tools': Symbols.handyman,
};

final defaultCategory = <StoredCategory>[
  gymMembership, //exercise
  salon, //styler
  subscriptions, //subscriptions
  debt, //credit_score
  loans, //real_estate_agent
  credit, //credit_card
  education, //school
  business, //storefront
  mortgage, //real_estate_agent
  vacations, //holiday_village
  movies, //theaters
  games, //toys_and_games
  entertainment, //attractions
  charity, //volunteer_activism
  specialOccasion, //special_character
  gifts, //featured_seasonal_and_gifts
  donations, //volunteer_activism
  transportation, //emoji_transportation
  investing, //finance_mode
  food, //fastfood
  groceries, //grocery
  restaurants, //restaurant
  electricity, //water_ec
  phone, //smartphone
  cable, //cable
  internet, //wifi
  clothing, //apparel
  medical, //medical_services
  dental, //dentistry
  medications, //medication_liquid
  householdItems, //flatware
  householdSupplies, //household_supplies
  cleaningSupplies, //cleaning_bucket
  tools, //handyman
];

final categoryWidgets = <Icon>[
  const Icon(
    FontAwesomeIcons.house,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.bagShopping,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.bowlFood,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.moneyBills,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.creditCard,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.bookMedical,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.gasPump,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.personRunning,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.piggyBank,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.personMilitaryToPerson,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.cheese,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.pizzaSlice,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.artstation,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.hospital,
    size: 32,
    color: Colors.white,
  ),
  const Icon(
    FontAwesomeIcons.artstation,
    size: 32,
    color: Colors.white,
  ),
];
final colorMapper = <String, Color>{
  'red': Colors.red,
  'yellow': Colors.yellow,
  'blue': Colors.blue,
  'white': Colors.white,
  'green': Colors.green,
  'cyan_accent': Colors.cyanAccent,
  'orange': Colors.orange,
  'pink': Colors.pink,
  'purple': Colors.purple,
  'brown': Colors.brown,
  'blue_grey': Colors.blueGrey,
  'light_blue': Colors.lightBlue,
  'blue_accent': Colors.blueAccent,
  'indigo': Colors.indigo,
  'light_green': Colors.lightGreen,
  'deep_orange': Colors.deepOrange,
  'grey': Colors.grey,
  'red_accent': Colors.redAccent,
  'deep_orange_accent': Colors.deepOrangeAccent,
  'deep_purple_accent': Colors.deepPurpleAccent,
  'orange_accent': Colors.orangeAccent,
};
final colorPickerWidgets = <Color>[
  Colors.red,
  Colors.yellow,
  Colors.blue,
  Colors.white,
  Colors.green,
  Colors.cyanAccent,
  Colors.orange,
  Colors.pink,
  Colors.purple,
  Colors.black,
  Colors.brown,
  Colors.blueGrey,
  Colors.lightBlue,
  Colors.blueAccent,
  Colors.indigo,
  Colors.lightGreen,
  Colors.deepOrange,
  Colors.grey,
  Colors.redAccent,
  Colors.cyanAccent,
  Colors.deepOrangeAccent,
  Colors.deepPurpleAccent,
  Colors.orangeAccent,
];
//final string2IconData =  <String, IconData>{
//   "local_dining": Icons.local_dining
//   ...
// };

// final plusIconData = <String, IconData>{"plus_sign": Icons.add};
