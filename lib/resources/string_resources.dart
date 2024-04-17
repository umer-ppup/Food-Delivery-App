class StringResources{
  static const String splashMiddleText = "Food Delivery App";
  static const String companyName = "ATRULE Technologies";
  static const String skip = "SKIP";
  static const String next = "NEXT";
  static const String getStarted = "GET STARTED NOW";
  static const String location = "App will use your current location to search restaurants near you";
  static const String okLocation = "OK";
  static const String otherLocation = "Choose another location";
  static const String search = "Search";
  static const String feature = "Featured";
  static const String allRes = "All restaurants";
  static const String about = "About";
  static const String reviews = "Reviews";
  static bool visible = false;
  static final kEmailValidatorRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  static final RegExp kPhoneValidatorRegExp =
  RegExp(r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$");
  static String phoneExp =
      r"^((\+92)|(0092))-{0,1}\d{3}-{0,1}\d{7}$|^\d{11}$|^\d{4}-\d{7}$";

  static const kLabelCardNumber = 'Number';
  static const kHintCardNumber = 'XXXX XXXX XXXX XXXX';
  static const kLabelCardExpiryDate = 'Expired Date';
  static const kHintCardExpiryDate = 'XX/XX';
  static const kLabelCardCVV = 'CVV';
  static const kHintCardCVV = 'XXX';
  static const kLabelCardHolder = 'Card Holder';
  static const kHintCardHolder = 'Card Holder';

  static String name;
  static String email;
  static String phoneNumber;
  static String password;
  static String confirmPassword;

  static String comment;

  static const bool isOnline = false;

  static const String userName = "Name";
  static const String userEmail = "Email";
  static const String userPhoneNumber = "Phone Number";
  static const String userPassword = "Password";
  static const String userConfirmPassword= "Confirm Password";
}