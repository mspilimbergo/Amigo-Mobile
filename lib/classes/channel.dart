class Channel {
  String channelId;
  String name;
  String description;
  String schoolId;
  String memberCount;
  String createdOn; 
  String photo;

  Channel({this.channelId, this.name, this.description, this.schoolId, this.memberCount, this.createdOn, this.photo});

  Channel.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    name = json['name'];
    description = json['description'];
    schoolId = json['school_id'];
    memberCount = json['member_count'];
    createdOn = json['created_on'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_id'] = this.channelId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['school_id'] = this.schoolId;
    return data;
  }
}
