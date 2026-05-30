class TouristLandmark {
  final int id;
  final String imagePath;
  final String title;
  final String city;
  final String rating;

  const TouristLandmark({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.city,
    required this.rating,
  });
}

class TouristGroupTrip {
  final String imagePath;
  final String title;
  final String city;
  final String date;
  final String duration;
  final String maxPeople;
  final String price;
  final String category;

  const TouristGroupTrip({
    required this.imagePath,
    required this.title,
    required this.city,
    required this.date,
    required this.duration,
    required this.maxPeople,
    required this.price,
    required this.category,
  });
}

const touristFilters = <String>[
  'History',
  'Culture',
  'Archaeology',
  'Religious',
  'Adventure',
];

const touristLandmarks = <TouristLandmark>[
  TouristLandmark(
    id: 1,
    imagePath: 'assets/images/2th.jpg',
    title: 'Great Pyramids of Giza',
    city: 'Giza',
    rating: '4.7',
  ),
  TouristLandmark(
    id: 2,
    imagePath: 'assets/images/3th.jpg',
    title: 'Temple of Philae',
    city: 'Aswan',
    rating: '4.9',
  ),
  TouristLandmark(
    id: 3,
    imagePath: 'assets/images/4th.jpg',
    title: 'Valley of the Kings',
    city: 'Luxor',
    rating: '4.8',
  ),
];

const touristGroupTrips = <TouristGroupTrip>[
  TouristGroupTrip(
    imagePath: 'assets/images/2th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'History',
  ),
    TouristGroupTrip(
    imagePath: 'assets/images/2th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'History',
  ),
    TouristGroupTrip(
    imagePath: 'assets/images/2th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'History',
  ),
    TouristGroupTrip(
    imagePath: 'assets/images/2th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'History',
  ),
    TouristGroupTrip(
    imagePath: 'assets/images/2th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'History',
  ),
    TouristGroupTrip(
    imagePath: 'assets/images/2th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'History',
  ),
  TouristGroupTrip(
    imagePath: 'assets/images/5th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'Archaeology',
  ),
  TouristGroupTrip(
    imagePath: 'assets/images/3th.jpg',
    title: 'Ancient Wonders of Egypt',
    city: 'Giza',
    date: 'Fri 09 Feb, 2026',
    duration: '1 Day',
    maxPeople: '40',
    price: r'$ 120',
    category: 'Culture',
  ),
];
