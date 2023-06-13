class VendorUserModel {
  final bool? approved;
  final String vendorId;
  final String? businessName;
  final String? phoneNumber;
  final String? email;
  final String? storeImage;
  final String? taxNumber;
  final String? cityValue;
  final String? stateValue;
  final String? taxRegistered;
  final String? countryValue;

  VendorUserModel(
      {required this.approved,
        required this.vendorId,
      required this.businessName,
      required this.phoneNumber,
      required this.email,
      required this.storeImage,
      required this.taxNumber,
      required this.cityValue,
      required this.stateValue,
      required this.taxRegistered,
      required this.countryValue});

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json["approved"]! as bool,
          vendorId: json["vendorId"]! as String,
          businessName: json["businessName"]! as String,
          countryValue: json["countryValue"]! as String,
          cityValue: json["cityValue"]! as String,
          stateValue: json["stateValue"]! as String,
          email: json["email"]! as String,
          phoneNumber: json["phoneNumber"]! as String,
          storeImage: json["storeImage"]! as String,
          taxNumber: json["taxNumber"]! as String,
          taxRegistered: json["taxRegistered"]! as String,
        );

  Map<String, Object?> toJson() {
    return {
      "approved": approved,
      "vendorId": vendorId,
      "businessName": businessName,
      "countryValue": countryValue,
      "cityValue": cityValue,
      "stateValue": stateValue,
      "email": email,
      "phoneNumber": phoneNumber,
      "storeImage": storeImage,
      "taxNumber": taxNumber,
      "taxRegistered": taxRegistered,
    };
  }
}
