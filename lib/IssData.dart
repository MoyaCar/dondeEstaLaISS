class IssData {
  final double latitude;
  final double longitude;

  IssData({this.latitude, this.longitude});
  factory IssData.fromApi(Map<String, dynamic> json) {
    return IssData(latitude: json['latitude'], longitude: json['longitude']);
  }
}