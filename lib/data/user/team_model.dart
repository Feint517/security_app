class TeamModel {
  final String teamId;
  String name;
  String description;
  final List<dynamic> members;

  TeamModel({
    required this.teamId,
    required this.name,
    required this.description,
    required this.members,
  });

  //* Factory method to create a TeamModel from JSON
  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      teamId: json['_id'],
      name: json['name'],
      description: json['description'],
      members: json['members'],
    );
  }
}
