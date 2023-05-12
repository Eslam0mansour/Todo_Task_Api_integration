// class User {
//   User({
//       this.id,
//       this.userName,
//       this.normalizedUserName,
//       this.email,
//       this.normalizedEmail,
//       this.emailConfirmed,
//       this.passwordHash,
//       this.securityStamp,
//       this.concurrencyStamp,
//       this.phoneNumber,
//       this.phoneNumberConfirmed,
//       this.twoFactorEnabled,
//       this.lockoutEnd,
//       this.lockoutEnabled,
//       this.accessFailedCount,});
//
//   User.fromJson(dynamic json) {
//     id = json['id'];
//     userName = json['userName'];
//     normalizedUserName = json['normalizedUserName'];
//     email = json['email'];
//     normalizedEmail = json['normalizedEmail'];
//     emailConfirmed = json['emailConfirmed'];
//     passwordHash = json['passwordHash'];
//     securityStamp = json['securityStamp'];
//     concurrencyStamp = json['concurrencyStamp'];
//     phoneNumber = json['phoneNumber'];
//     phoneNumberConfirmed = json['phoneNumberConfirmed'];
//     twoFactorEnabled = json['twoFactorEnabled'];
//     lockoutEnd = json['lockoutEnd'];
//     lockoutEnabled = json['lockoutEnabled'];
//     accessFailedCount = json['accessFailedCount'];
//   }
//   String id;
//   String userName;
//   String normalizedUserName;
//   String email;
//   String normalizedEmail;
//   String emailConfirmed;
//   String passwordHash;
//   String securityStamp;
//   String concurrencyStamp;
//   String phoneNumber;
//   String phoneNumberConfirmed;
//   String twoFactorEnabled;
//   String lockoutEnd;
//   String lockoutEnabled;
//   String accessFailedCount;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['userName'] = userName;
//     map['normalizedUserName'] = normalizedUserName;
//     map['email'] = email;
//     map['normalizedEmail'] = normalizedEmail;
//     map['emailConfirmed'] = emailConfirmed;
//     map['passwordHash'] = passwordHash;
//     map['securityStamp'] = securityStamp;
//     map['concurrencyStamp'] = concurrencyStamp;
//     map['phoneNumber'] = phoneNumber;
//     map['phoneNumberConfirmed'] = phoneNumberConfirmed;
//     map['twoFactorEnabled'] = twoFactorEnabled;
//     map['lockoutEnd'] = lockoutEnd;
//     map['lockoutEnabled'] = lockoutEnabled;
//     map['accessFailedCount'] = accessFailedCount;
//     return map;
//   }
//
// }