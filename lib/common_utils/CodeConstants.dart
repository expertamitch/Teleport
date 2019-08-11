class CodeConstants {
//  collection constants
  static const String COLLECTION_USERS = "users";
  static const String COLLECTION_ACTIVE_DRIVERS = "activeDrivers";
  static const String COLLECTION_APPLICATION= "application";
  static const String DOC_CURRENCY_RATES= "currency_rates";

//  response code constants
  static const int CODE_SUCCESS = 200;
  static const int CODE_EXCEPTION = 504;

//  Storage constants
  static const String STORAGE_USER = "UserProfileImage";
  static const String TOKEN = "token";
  static const String USER_ID = "userid";
  static const String USER = "user";

// keys Constants

  static const String FIELD_ID = "id";
  static const String FIELD_EMAIL = "email";
  static const String FIELD_FIRSTNAME = "first_name";
  static const String FIELD_LASTNAME = "last_name";
  static const String FIELD_NICKNAME = "nick_name";
  static const String FIELD_PHONENUMBER = "phone_number";
  static const String FIELD_IMAGE = "image";
  static const String FIELD_RIDER = "rider";

// ride params
  static const String FIELD_RIDE_PARAMS = "ride_params";
  static const String FIELD_MIN_RIDE_PRICE = "min_ride_price";
  static const String FIELD_MIN_RIDE_LENGTH = "min_ride_length";
  static const String FIELD_NEXT_TIME_BLOC_LENGTH = "next_time_bloc_length";
  static const String FIELD_NEXT_TIME_BLOC_PRICE = "next_time_bloc_price";
  static const String FIELD_CURRENCY = "currency";

  //  location params
  static const String FIELD_LOCATION = "location";
  static const String FIELD_LATITUDE = "latitude";
  static const String FIELD_LONGITUDE = "longitude";
  static const String FIELD_LOCATION_UPDATE_TIME = "location_update_time";

  static const String invalidEmailMessage = "Invalid email";
  static const String emptyPasswordMessage = "This field must not be empty";
  static const String passwordValidateMessage =
      "Password must be atleast of 6 characters";

//  Error code and params
  static const String CODE_= "code";

}
