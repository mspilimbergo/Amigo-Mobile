class Populartag {
  bool success;
  List<Populartags> tags;

  Populartag({this.success, this.tags});

  Populartag.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['tags'] != null) {
      tags = new List<Populartags>();
      json['tags'].forEach((v) {
        tags.add(new Populartags.fromJson(v));
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

class Populartags {
  String tagId;
  String name;
  String memberCount;

  Populartags({this.tagId, this.name, this.memberCount});

  Populartags.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    name = json['name'];
    memberCount = json['member_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['name'] = this.name;
    data['member_count'] = this.memberCount;
    return data;
  }
}
