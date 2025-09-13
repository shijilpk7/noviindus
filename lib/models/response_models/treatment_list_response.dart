class TreatmentListResponse {
  bool? status;
  String? message;
  List<Treatments>? treatments;

  TreatmentListResponse({this.status, this.message, this.treatments});

  TreatmentListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['treatments'] != null) {
      treatments = <Treatments>[];
      json['treatments'].forEach((v) {
        treatments!.add(Treatments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (treatments != null) {
      data['treatments'] = treatments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Treatments {
  int? id;
  List<TreatmentBranches>? branches;
  String? name;
  String? duration;
  String? price;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Treatments({
    this.id,
    this.branches,
    this.name,
    this.duration,
    this.price,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Treatments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['branches'] != null) {
      branches = <TreatmentBranches>[];
      json['branches'].forEach((v) {
        branches!.add(TreatmentBranches.fromJson(v));
      });
    }
    name = json['name'];
    duration = json['duration'];
    price = json['price'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (branches != null) {
      data['branches'] = branches!.map((v) => v.toJson()).toList();
    }
    data['name'] = name;
    data['duration'] = duration;
    data['price'] = price;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TreatmentBranches {
  int? id;
  String? name;
  int? patientsCount;
  String? location;
  String? phone;
  String? mail;
  String? address;
  String? gst;
  bool? isActive;

  TreatmentBranches({
    this.id,
    this.name,
    this.patientsCount,
    this.location,
    this.phone,
    this.mail,
    this.address,
    this.gst,
    this.isActive,
  });

  TreatmentBranches.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    patientsCount = json['patients_count'];
    location = json['location'];
    phone = json['phone'];
    mail = json['mail'];
    address = json['address'];
    gst = json['gst'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['patients_count'] = patientsCount;
    data['location'] = location;
    data['phone'] = phone;
    data['mail'] = mail;
    data['address'] = address;
    data['gst'] = gst;
    data['is_active'] = isActive;
    return data;
  }
}
