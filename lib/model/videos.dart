
class Videos {
  Videos({
    required this.url,
    required this.thumbnail,
    required this.category,
    required this.likes,
  });

  String url;
  String thumbnail;
  String category;
  dynamic likes;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    url: json["url"],
    thumbnail: json["thumbnail"],
    category: json["category"]??json["cattegory"],
    likes: json["likes"],
  );

}
