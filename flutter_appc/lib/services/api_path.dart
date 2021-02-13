class APIPath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';
  static String phone(String uid, String phoneId) =>
      'users/$uid/phones/$phoneId';
  static String birthday(String uid, String birthdayId) =>
      'users/$uid/birthday/$birthdayId';
  static String phones(String uid) => 'users/$uid/phones';
  static String birthdays(String uid) => 'users/$uid/birthday';
  static String email(String uid, String emailId) =>
      'users/$uid/emails/$emailId';
  static String emails(String uid) => 'users/$uid/emails';
  static String address(String uid, String addressId) =>
      'users/$uid/addresss/$addressId';
  static String addresss(String uid) => 'users/$uid/addresss';
  static String profile(String uid, String profileId) =>
      'users/$uid/profile/$profileId';
  static String profiles(String uid) => 'users/$uid/data';
  static String entry(String uid, String entryId) =>
      'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';
}
