class ProjectModel {
  final String projectId;
  final String projectCode;
  String name;
  String teamId;
  int budget;
  String startDate;
  String timeline;
  int advancementRate;

  ProjectModel({
    required this.projectId,
    required this.projectCode,
    required this.name,
    required this.teamId,
    required this.budget,
    required this.startDate,
    required this.timeline,
    required this.advancementRate,
  });

  //* Factory method to create a TeamModel from JSON
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectId: json['_id'],
      projectCode: json['projectCode'],
      name: json['name'],
      teamId: json['team'],
      budget: json['budget'],
      startDate: json['startDate'],
      timeline: json['timeline'],
      advancementRate: json['advancementRate'],
    );
  }
}
