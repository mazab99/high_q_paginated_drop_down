class AnimePaginatedList {
  List<Anime>? animeList;

  AnimePaginatedList({this.animeList});

  AnimePaginatedList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      animeList = <Anime>[];
      json['data'].forEach((v) {
        animeList!.add(Anime.fromJson(v));
      });
    }
  }
}

class Anime {
  int? malId;
  String? title;

  Anime({
    this.malId,
    this.title,
  });

  Anime.fromJson(Map<String, dynamic> json) {
    malId = json['mal_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mal_id'] = malId;
    data['title'] = title;
    return data;
  }

  fromJson(Map<String, dynamic> json) => Anime.fromJson(json);
}
