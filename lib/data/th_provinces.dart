class Province {
  final String nameTh;
  final String nameEn;
  final double lat;
  final double lon;

  Province(this.nameTh, this.nameEn, this.lat, this.lon);
}

// กรุงเทพฯ และปริมณฑล
final provincesCentralMetro = [
  Province('กรุงเทพมหานคร', 'Bangkok', 13.7563, 100.5018),
  Province('นนทบุรี', 'Nonthaburi', 13.8621, 100.5144),
  Province('ปทุมธานี', 'Pathum Thani', 14.0200, 100.5250),
  Province('สมุทรปราการ', 'Samut Prakan', 13.5991, 100.5990),
  Province('นครปฐม', 'Nakhon Pathom', 13.8199, 100.0620),
  Province('สมุทรสาคร', 'Samut Sakhon', 13.5475, 100.2737),
];

// ภาคกลาง
final provincesCentral = [
  Province('พระนครศรีอยุธยา', 'Ayutthaya', 14.3532, 100.5684),
  Province('สระบุรี', 'Saraburi', 14.5289, 100.9101),
  Province('ลพบุรี', 'Lopburi', 14.7995, 100.6534),
  Province('อ่างทอง', 'Ang Thong', 14.5896, 100.4550),
  Province('สิงห์บุรี', 'Sing Buri', 14.8879, 100.4049),
  Province('ชัยนาท', 'Chai Nat', 15.1859, 100.1250),
  Province('นครสวรรค์', 'Nakhon Sawan', 15.7047, 100.1372),
  Province('อุทัยธานี', 'Uthai Thani', 15.3794, 100.0240),
];

// ภาคตะวันออก
final provincesEast = [
  Province('ชลบุรี', 'Chonburi', 13.3611, 100.9847),
  Province('ระยอง', 'Rayong', 12.6814, 101.2819),
  Province('จันทบุรี', 'Chanthaburi', 12.6114, 102.1039),
  Province('ตราด', 'Trat', 12.2420, 102.5170),
  Province('ปราจีนบุรี', 'Prachin Buri', 14.0495, 101.3705),
  Province('สระแก้ว', 'Sa Kaeo', 13.8140, 102.0720),
  Province('นครนายก', 'Nakhon Nayok', 14.2040, 101.2130),
];

// ภาคตะวันตก
final provincesWest = [
  Province('ราชบุรี', 'Ratchaburi', 13.5367, 99.8171),
  Province('กาญจนบุรี', 'Kanchanaburi', 14.0220, 99.5328),
  Province('เพชรบุรี', 'Phetchaburi', 13.1110, 99.9398),
  Province('ประจวบคีรีขันธ์', 'Prachuap Khiri Khan', 11.8120, 99.7970),
];

// ภาคเหนือ
final provincesNorth = [
  Province('เชียงใหม่', 'Chiang Mai', 18.7883, 98.9853),
  Province('เชียงราย', 'Chiang Rai', 19.9072, 99.8309),
  Province('ลำปาง', 'Lampang', 18.2888, 99.4909),
  Province('ลำพูน', 'Lamphun', 18.5739, 99.0087),
  Province('แม่ฮ่องสอน', 'Mae Hong Son', 19.3013, 97.9685),
  Province('แพร่', 'Phrae', 18.1459, 100.1411),
  Province('น่าน', 'Nan', 18.7830, 100.7790),
  Province('พะเยา', 'Phayao', 19.1920, 99.8783),
  Province('อุตรดิตถ์', 'Uttaradit', 17.6200, 100.0993),
  Province('พิษณุโลก', 'Phitsanulok', 16.8283, 100.2729),
  Province('สุโขทัย', 'Sukhothai', 17.0078, 99.8236),
  Province('เพชรบูรณ์', 'Phetchabun', 16.4189, 101.1561),
  Province('กำแพงเพชร', 'Kamphaeng Phet', 16.4827, 99.5220),
  Province('ตาก', 'Tak', 16.8697, 99.1256),
];

// ภาคตะวันออกเฉียงเหนือ (อีสาน)
final provincesNortheast = [
  Province('นครราชสีมา', 'Nakhon Ratchasima', 14.9799, 102.0977),
  Province('บุรีรัมย์', 'Buri Ram', 14.9940, 103.1039),
  Province('สุรินทร์', 'Surin', 14.8820, 103.4937),
  Province('ศรีสะเกษ', 'Si Sa Ket', 15.1186, 104.3222),
  Province('อุบลราชธานี', 'Ubon Ratchathani', 15.2383, 104.8487),
  Province('ยโสธร', 'Yasothon', 15.7920, 104.1450),
  Province('อำนาจเจริญ', 'Amnat Charoen', 15.8600, 104.6300),
  Province('ขอนแก่น', 'Khon Kaen', 16.4419, 102.8350),
  Province('มหาสารคาม', 'Maha Sarakham', 16.1836, 103.3000),
  Province('ร้อยเอ็ด', 'Roi Et', 16.0567, 103.6530),
  Province('กาฬสินธุ์', 'Kalasin', 16.4320, 103.5060),
  Province('สกลนคร', 'Sakon Nakhon', 17.1546, 104.1400),
  Province('นครพนม', 'Nakhon Phanom', 17.4108, 104.7780),
  Province('มุกดาหาร', 'Mukdahan', 16.5430, 104.7200),
  Province('หนองคาย', 'Nong Khai', 17.8783, 102.7420),
  Province('บึงกาฬ', 'Bueng Kan', 18.3630, 103.6490),
  Province('หนองบัวลำภู', 'Nong Bua Lam Phu', 17.2046, 102.4390),
  Province('เลย', 'Loei', 17.4860, 101.7220),
  Province('อุดรธานี', 'Udon Thani', 17.4138, 102.7877),
  Province('ชัยภูมิ', 'Chaiyaphum', 15.8060, 102.0310),
];

// ภาคใต้
final provincesSouth = [
  Province('ภูเก็ต', 'Phuket', 7.8804, 98.3923),
  Province('กระบี่', 'Krabi', 8.0863, 98.9063),
  Province('สุราษฎร์ธานี', 'Surat Thani', 9.1382, 99.3215),
  Province('พังงา', 'Phangnga', 8.4510, 98.5346),
  Province('ชุมพร', 'Chumphon', 10.4930, 99.1800),
  Province('ระนอง', 'Ranong', 9.9630, 98.6340),
  Province('นครศรีธรรมราช', 'Nakhon Si Thammarat', 8.4304, 99.9631),
  Province('ตรัง', 'Trang', 7.5590, 99.6110),
  Province('พัทลุง', 'Phatthalung', 7.6167, 100.0770),
  Province('สงขลา', 'Songkhla', 7.2008, 100.5951),
  Province('สตูล', 'Satun', 6.6238, 100.0674),
  Province('ยะลา', 'Yala', 6.5410, 101.2810),
  Province('นราธิวาส', 'Narathiwat', 6.4256, 101.8253),
];

/// รวมจังหวัดทั้งหมด
final provincesTH = [
  ...provincesCentralMetro,
  ...provincesCentral,
  ...provincesEast,
  ...provincesWest,
  ...provincesNorth,
  ...provincesNortheast,
  ...provincesSouth,
];
