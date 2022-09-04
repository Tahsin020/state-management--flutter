class TravelModel {
  final String title;
  final String subTitle;
  final String imageName;

  TravelModel({required this.title, required this.subTitle, required this.imageName});

  String get imagePath => "assets/images/feed/$imageName.png";

  static final List<TravelModel> mockItems = [
    TravelModel(title: "Sapporo", subTitle: "Sopporo Tower", imageName: "discover"),
    TravelModel(title: "Osaka", subTitle: "Japon ", imageName: "dest"),
    TravelModel(title: "Costentino", subTitle: "Costantinonoto", imageName: "cosentino"),
  ];
}
