import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:transactions_api/transactions_api.dart';

///Todo This needs to become a list and then stored in a Repo
///User categories will be stored here as well.
const business = TransactionCategoryCompanion(
  name: Value('Business'),
  colorName: Value('yellow'),
  iconName: Value('business'),
);

const salary = TransactionCategoryCompanion(
  name: Value('Business'),
  colorName: Value('yellow'),
  iconName: Value('salary'),
);

const mortgage = TransactionCategoryCompanion(
    name: Value('Mortgage'),
    iconName: Value('mortgage'),
    colorName: Value('blue'));
const vacations = TransactionCategoryCompanion(
    name: Value('Vacations'),
    iconName: Value('vacations'),
    colorName: Value('white'));
const movies = TransactionCategoryCompanion(
    name: Value('Movies'),
    iconName: Value('movies'),
    colorName: Value('green'));
const games = TransactionCategoryCompanion(
    name: Value('Games'),
    iconName: Value('games'),
    colorName: Value('cyan_accent'));
const entertainment = TransactionCategoryCompanion(
    name: Value('Entertainment'),
    iconName: Value('entertainment'),
    colorName: Value('orange'));
const charity = TransactionCategoryCompanion(
    name: Value('Charity'),
    iconName: Value('charity'),
    colorName: Value('pink'));
const specialOccasion = TransactionCategoryCompanion(
    name: Value('SpecialOccasion'),
    iconName: Value('special_occasion'),
    colorName: Value('purple'));
const gifts = TransactionCategoryCompanion(
    name: Value('Gifts'),
    iconName: Value('gifts'),
    colorName: Value('blue_grey'));
const donations = TransactionCategoryCompanion(
    name: Value('donations'),
    iconName: Value('donations'),
    colorName: Value('brown'));
const transportation = TransactionCategoryCompanion(
    name: Value('Transportation'),
    iconName: Value('transportation'),
    colorName: Value('blue_grey'));
const investing = TransactionCategoryCompanion(
    name: Value('Investing'),
    iconName: Value('investing'),
    colorName: Value('light_blue'));
const food = TransactionCategoryCompanion(
    name: Value('Food'),
    iconName: Value('food'),
    colorName: Value('blue_accent'));
const groceries = TransactionCategoryCompanion(
    name: Value('Groceries'),
    iconName: Value('groceries'),
    colorName: Value('indigo'));
const restaurants = TransactionCategoryCompanion(
    name: Value('Restaurants'),
    iconName: Value('retaurants'),
    colorName: Value('light_green'));
const electricity = TransactionCategoryCompanion(
    name: Value('Electricity'),
    iconName: Value('electricity'),
    colorName: Value('deep_orange'));
const phone = TransactionCategoryCompanion(
    name: Value('Phone'), iconName: Value('phone'), colorName: Value('grey'));
const cable = TransactionCategoryCompanion(
    name: Value('Cable'),
    iconName: Value('cable'),
    colorName: Value('red_accent'));
const internet = TransactionCategoryCompanion(
    name: Value('Internet'),
    iconName: Value('internet'),
    colorName: Value('cyan_accent'));
const clothing = TransactionCategoryCompanion(
    name: Value('Clothing'),
    iconName: Value('clothing'),
    colorName: Value('blue_grey'));
const medical = TransactionCategoryCompanion(
    name: Value('Medical'),
    iconName: Value('medical'),
    colorName: Value('deep_purple'));
const dental = TransactionCategoryCompanion(
    name: Value('Dental'),
    iconName: Value('dental'),
    colorName: Value('orange_accent'));
const medications = TransactionCategoryCompanion(
    name: Value('Medication'),
    iconName: Value('medications'),
    colorName: Value('deep_urple_accent'));
const insurance = TransactionCategoryCompanion(
    name: Value('Insurance'),
    iconName: Value('investing'),
    colorName: Value('green_accent'));
const householdItems = TransactionCategoryCompanion(
    name: Value('Household Items'),
    iconName: Value('household_items'),
    colorName: Value('brown'));
const householdSupplies = TransactionCategoryCompanion(
    name: Value('Household Supplies'),
    iconName: Value('household_supplies'),
    colorName: Value('pink'));
const cleaningSupplies = TransactionCategoryCompanion(
    name: Value('Cleaning Supplies'),
    iconName: Value('cleaning_supplies'),
    colorName: Value('red_accent'));
const tools = TransactionCategoryCompanion(
    name: Value('Tools'), iconName: Value('tools'), colorName: Value('brown'));
const gymMembership = TransactionCategoryCompanion(
    name: Value('Gym'),
    iconName: Value('exercise'),
    colorName: Value('deep_cyan'));
const salon = TransactionCategoryCompanion(
    name: Value('Salon'),
    iconName: Value('styler'),
    colorName: Value('orange'));
const subscriptions = TransactionCategoryCompanion(
    name: Value('Subscriptions'),
    iconName: Value('subscriptions'),
    colorName: Value('pink_accent'));
const debt = TransactionCategoryCompanion(
    name: Value('Debt'),
    iconName: Value('debt'),
    colorName: Value('light_blue'));
const loans = TransactionCategoryCompanion(
    name: Value('Loans'),
    iconName: Value('loans'),
    colorName: Value('blue_accent'));
const credit = TransactionCategoryCompanion(
    name: Value('Credit'),
    iconName: Value('credit'),
    colorName: Value('deep_orange'));
const education = TransactionCategoryCompanion(
    name: Value('Education'),
    iconName: Value('education'),
    colorName: Value('deep_purple_accent'));

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

final defaultCategory = <TransactionCategoryCompanion>[
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
