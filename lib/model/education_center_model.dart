class EducationCenter {
  final String name;
  final String address;
  final String phone;
  final String website;
  final String image;
 

  EducationCenter({
    required this.name,
    required this.address,
    required this.phone,
    required this.website,
    required this.image,
 
  });

  factory EducationCenter.fromJson(Map<String, dynamic> json) {
    return EducationCenter(
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      website: json['website'],
      image: json['image'],
      
    );
  }
}
