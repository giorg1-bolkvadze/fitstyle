class Hospital {
  final String name;
  final String address;
  final String phone;
  final String website;

  Hospital({
    required this.name,
    required this.address,
    required this.phone,
    required this.website,
  });
}

List<Hospital> hospitals = [
  Hospital(
    name: "Acıbadem Hastanesi",
    address: "Bağdat Cad. No:238, Kadıköy, İstanbul",
    phone: "+90 216 544 44 44",
    website: "https://www.acibadem.com.tr/",
  ),
  Hospital(
    name: "Memorial Şişli Hastanesi",
    address: "Okmeydanı, Darülaceze Cd. No:14, 34382 Şişli/İstanbul",
    phone: "+90 212 314 66 66",
    website: "https://www.memorial.com.tr/",
  ),
  Hospital(
    name: "Medipol Mega Hastaneler Kompleksi",
    address: "Bağcılar-Güneşli, TEM Avrupa Otoyolu, 34214 İstanbul",
    phone: "+90 212 460 77 77",
    website: "https://www.medipol.com.tr/",
  ),
  Hospital(
    name: "Florence Nightingale Hastanesi",
    address: "Abide-i Hürriyet Cd. No: 166, Şişli, İstanbul",
    phone: "+90 212 224 49 50",
    website: "https://www.florence.com.tr/",
  ),
  Hospital(
    name: "Koç Üniversitesi Hastanesi",
    address: "Davutpaşa Cd. No:4, 34010 Zeytinburnu/İstanbul",
    phone: "+90 850 250 82 50",
    website: "https://www.kuh.ku.edu.tr/",
  ),
  Hospital(
    name: "Medicana International İstanbul",
    address: "Beylikdüzü, Büyükşehir Mah. Cumhuriyet Cad. No:1",
    phone: "+90 212 867 75 00",
    website: "https://www.medicana.com.tr/",
  ),
  Hospital(
    name: "Başkent Üniversitesi Hastanesi",
    address: "Fevzi Çakmak Cd. No:45, Bahçelievler, Ankara",
    phone: "+90 312 203 68 68",
    website: "https://www.baskenthastaneleri.com/",
  ),
  Hospital(
    name: "Hacettepe Üniversitesi Hastanesi",
    address: "Sıhhiye, 06100 Altındağ/Ankara",
    phone: "+90 312 305 50 00",
    website: "https://www.hacettepehastanesi.com/",
  ),
  Hospital(
    name: "Ankara Şehir Hastanesi",
    address: "Bilkent, Üniversiteler Mh., 06800 Çankaya/Ankara",
    phone: "+90 312 552 60 00",
    website: "https://sehirhastanesi.saglik.gov.tr/",
  ),
  Hospital(
    name: "Ege Üniversitesi Hastanesi",
    address: "Bornova, 35100 İzmir",
    phone: "+90 232 390 40 00",
    website: "https://www.egehastanesi.com.tr/",
  ),
];
