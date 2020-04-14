class Tag {
  bool success;
  List<Tags> tags;

  Tag({this.success, this.tags});

  Tag.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tags'] != null) {
      tags = new List<Tags>();
      json['tags'].forEach((v) {
        tags.add(new Tags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tags {
  String tagId;
  String name;
  String photo;

  Tags({this.tagId, this.name, this.photo});

  Tags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    name = json['name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['name'] = this.name;
    data['photo'] = this.photo;
    return data;
  }
}
