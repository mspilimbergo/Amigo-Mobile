class Channel {
  final String channelId;
  final String name;
  final String description;
  final int memberCount;
  final String location;
  final String photo; // Link to imgur image for now
  final String createdOn;

  Channel(this.channelId, this.name, this.description, this.memberCount, this.location, this.photo, this.createdOn);
}