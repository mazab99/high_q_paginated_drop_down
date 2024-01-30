
class ShopsModel {
  List<ShopsModelData>? shopsModelData;
  Links? links;
  Meta? meta;

  ShopsModel({this.shopsModelData, this.links, this.meta});

  ShopsModel.fromJson(Map<String, dynamic> json) {
    if(json["data"] is List) {
      shopsModelData = json["data"] == null ? null : (json["data"] as List).map((e) => ShopsModelData.fromJson(e)).toList();
    }
    if(json["links"] is Map) {
      links = json["links"] == null ? null : Links.fromJson(json["links"]);
    }
    if(json["meta"] is Map) {
      meta = json["meta"] == null ? null : Meta.fromJson(json["meta"]);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(shopsModelData != null) {
      _data["data"] = shopsModelData?.map((e) => e.toJson()).toList();
    }
    if(links != null) {
      _data["links"] = links?.toJson();
    }
    if(meta != null) {
      _data["meta"] = meta?.toJson();
    }
    return _data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links1>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({this.currentPage, this.from, this.lastPage, this.links, this.path, this.perPage, this.to, this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    if(json["current_page"] is int) {
      currentPage = json["current_page"];
    }
    if(json["from"] is int) {
      from = json["from"];
    }
    if(json["last_page"] is int) {
      lastPage = json["last_page"];
    }
    if(json["links"] is List) {
      links = json["links"] == null ? null : (json["links"] as List).map((e) => Links1.fromJson(e)).toList();
    }
    if(json["path"] is String) {
      path = json["path"];
    }
    if(json["per_page"] is int) {
      perPage = json["per_page"];
    }
    if(json["to"] is int) {
      to = json["to"];
    }
    if(json["total"] is int) {
      total = json["total"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["current_page"] = currentPage;
    _data["from"] = from;
    _data["last_page"] = lastPage;
    if(links != null) {
      _data["links"] = links?.map((e) => e.toJson()).toList();
    }
    _data["path"] = path;
    _data["per_page"] = perPage;
    _data["to"] = to;
    _data["total"] = total;
    return _data;
  }
}

class Links1 {
  dynamic url;
  String? label;
  bool? active;

  Links1({this.url, this.label, this.active});

  Links1.fromJson(Map<String, dynamic> json) {
    url = json["url"];
    if(json["label"] is String) {
      label = json["label"];
    }
    if(json["active"] is bool) {
      active = json["active"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["url"] = url;
    _data["label"] = label;
    _data["active"] = active;
    return _data;
  }
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    if(json["first"] is String) {
      first = json["first"];
    }
    if(json["last"] is String) {
      last = json["last"];
    }
    prev = json["prev"];
    if(json["next"] is String) {
      next = json["next"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["first"] = first;
    _data["last"] = last;
    _data["prev"] = prev;
    _data["next"] = next;
    return _data;
  }
}

class ShopsModelData {
  int? id;
  String? name;
  String? description;
  List<Categories>? categories;
  String? logo;
  int? avgRate;
  int? totalRates;
  Geo? geo;
  SocialMedia? socialMedia;
  WorkTime? workTime;
  String? email;
  String? phoneNumber;
  String? status;

  ShopsModelData({this.id, this.name, this.description, this.categories, this.logo, this.avgRate, this.totalRates, this.geo, this.socialMedia, this.workTime, this.email, this.phoneNumber, this.status});

  ShopsModelData.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["categories"] is List) {
      categories = json["categories"] == null ? null : (json["categories"] as List).map((e) => Categories.fromJson(e)).toList();
    }
    if(json["logo"] is String) {
      logo = json["logo"];
    }
    if(json["avg_rate"] is int) {
      avgRate = json["avg_rate"];
    }
    if(json["total_rates"] is int) {
      totalRates = json["total_rates"];
    }
    if(json["geo"] is Map) {
      geo = json["geo"] == null ? null : Geo.fromJson(json["geo"]);
    }
    if(json["social_media"] is Map) {
      socialMedia = json["social_media"] == null ? null : SocialMedia.fromJson(json["social_media"]);
    }
    if(json["work_time"] is Map) {
      workTime = json["work_time"] == null ? null : WorkTime.fromJson(json["work_time"]);
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["phone_number"] is String) {
      phoneNumber = json["phone_number"];
    }
    if(json["status"] is String) {
      status = json["status"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    if(categories != null) {
      _data["categories"] = categories?.map((e) => e.toJson()).toList();
    }
    _data["logo"] = logo;
    _data["avg_rate"] = avgRate;
    _data["total_rates"] = totalRates;
    if(geo != null) {
      _data["geo"] = geo?.toJson();
    }
    if(socialMedia != null) {
      _data["social_media"] = socialMedia?.toJson();
    }
    if(workTime != null) {
      _data["work_time"] = workTime?.toJson();
    }
    _data["email"] = email;
    _data["phone_number"] = phoneNumber;
    _data["status"] = status;
    return _data;
  }
}

class WorkTime {
  bool? isOpen;
  String? nextClose;
  String? nextOpen;

  WorkTime({this.isOpen, this.nextClose, this.nextOpen});

  WorkTime.fromJson(Map<String, dynamic> json) {
    if(json["is_open"] is bool) {
      isOpen = json["is_open"];
    }
    if(json["next_close"] is String) {
      nextClose = json["next_close"];
    }
    if(json["next_open"] is String) {
      nextOpen = json["next_open"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["is_open"] = isOpen;
    _data["next_close"] = nextClose;
    _data["next_open"] = nextOpen;
    return _data;
  }
}

class SocialMedia {
  dynamic facebook;
  dynamic twitter;
  dynamic whatsapp;
  dynamic snapchat;
  dynamic telegram;

  SocialMedia({this.facebook, this.twitter, this.whatsapp, this.snapchat, this.telegram});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebook = json["facebook"];
    twitter = json["twitter"];
    whatsapp = json["whatsapp"];
    snapchat = json["snapchat"];
    telegram = json["telegram"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["facebook"] = facebook;
    _data["twitter"] = twitter;
    _data["whatsapp"] = whatsapp;
    _data["snapchat"] = snapchat;
    _data["telegram"] = telegram;
    return _data;
  }
}

class Geo {
  String? address;
  String? zipCode;
  Region? region;
  City? city;
  Neighborhood? neighborhood;
  String? longitude;
  String? latitude;
  String? distance;

  Geo({this.address, this.zipCode, this.region, this.city, this.neighborhood, this.longitude, this.latitude, this.distance});

  Geo.fromJson(Map<String, dynamic> json) {
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["zip_code"] is String) {
      zipCode = json["zip_code"];
    }
    if(json["region"] is Map) {
      region = json["region"] == null ? null : Region.fromJson(json["region"]);
    }
    if(json["city"] is Map) {
      city = json["city"] == null ? null : City.fromJson(json["city"]);
    }
    if(json["neighborhood"] is Map) {
      neighborhood = json["neighborhood"] == null ? null : Neighborhood.fromJson(json["neighborhood"]);
    }
    if(json["longitude"] is String) {
      longitude = json["longitude"];
    }
    if(json["latitude"] is String) {
      latitude = json["latitude"];
    }
    if(json["distance"] is String) {
      distance = json["distance"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["address"] = address;
    _data["zip_code"] = zipCode;
    if(region != null) {
      _data["region"] = region?.toJson();
    }
    if(city != null) {
      _data["city"] = city?.toJson();
    }
    if(neighborhood != null) {
      _data["neighborhood"] = neighborhood?.toJson();
    }
    _data["longitude"] = longitude;
    _data["latitude"] = latitude;
    _data["distance"] = distance;
    return _data;
  }
}

class Neighborhood {
  int? id;
  String? name;

  Neighborhood({this.id, this.name});

  Neighborhood.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}

class City {
  int? id;
  String? name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}

class Region {
  int? id;
  String? name;

  Region({this.id, this.name});

  Region.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    return _data;
  }
}

class Categories {
  String? name;

  Categories({this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    if(json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["name"] = name;
    return _data;
  }
}