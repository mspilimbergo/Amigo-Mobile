class Channel {
  String channelId;
  String name;
  String description;
  String schoolId;

  Channel({this.channelId, this.name, this.description, this.schoolId});

  Channel.fromJson(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    name = json['name'];
    description = json['description'];
    schoolId = json['school_id'];
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
