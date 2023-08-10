class ProviceModel {
  final String provinceId;
  final String province;

  ProviceModel({
    required this.provinceId,
    required this.province,
  });

  factory ProviceModel.fromJson(Map<String, dynamic> json) {
    return ProviceModel(
      provinceId: json['province_id'],
      province: json['province'],
    );
  }
}
