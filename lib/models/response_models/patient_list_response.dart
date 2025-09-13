class PatientListResponse {
  bool? status;
  String? message;
  List<Patient>? patient;

  PatientListResponse({this.status, this.message, this.patient});

  PatientListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['patient'] != null) {
      patient = <Patient>[];
      json['patient'].forEach((v) {
        patient!.add(Patient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (patient != null) {
      data['patient'] = patient!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patient {
  int? id;
  List<PatientdetailsSet>? patientdetailsSet;
  Branch? branch;
  String? user;
  String? payment;
  String? name;
  String? phone;
  String? address;
  Null price;
  int? totalAmount;
  int? discountAmount;
  int? advanceAmount;
  int? balanceAmount;
  String? dateNdTime;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Patient({
    this.id,
    this.patientdetailsSet,
    this.branch,
    this.user,
    this.payment,
    this.name,
    this.phone,
    this.address,
    this.price,
    this.totalAmount,
    this.discountAmount,
    this.advanceAmount,
    this.balanceAmount,
    this.dateNdTime,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['patientdetails_set'] != null) {
      patientdetailsSet = <PatientdetailsSet>[];
      json['patientdetails_set'].forEach((v) {
        patientdetailsSet!.add(PatientdetailsSet.fromJson(v));
      });
    }
    branch = json['branch'] != null ? Branch.fromJson(json['branch']) : null;
    user = json['user'];
    payment = json['payment'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    price = json['price'];
    totalAmount = json['total_amount'];
    discountAmount = json['discount_amount'];
    advanceAmount = json['advance_amount'];
    balanceAmount = json['balance_amount'];
    dateNdTime = json['date_nd_time'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (patientdetailsSet != null) {
      data['patientdetails_set'] =
          patientdetailsSet!.map((v) => v.toJson()).toList();
    }
    if (branch != null) {
      data['branch'] = branch!.toJson();
    }
    data['user'] = user;
    data['payment'] = payment;
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['price'] = price;
    data['total_amount'] = totalAmount;
    data['discount_amount'] = discountAmount;
    data['advance_amount'] = advanceAmount;
    data['balance_amount'] = balanceAmount;
    data['date_nd_time'] = dateNdTime;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class PatientdetailsSet {
  int? id;
  String? male;
  String? female;
  int? patient;
  int? treatment;
  String? treatmentName;

  PatientdetailsSet({
    this.id,
    this.male,
    this.female,
    this.patient,
    this.treatment,
    this.treatmentName,
  });

  PatientdetailsSet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    male = json['male'];
    female = json['female'];
    patient = json['patient'];
    treatment = json['treatment'];
    treatmentName = json['treatment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['male'] = male;
    data['female'] = female;
    data['patient'] = patient;
    data['treatment'] = treatment;
    data['treatment_name'] = treatmentName;
    return data;
  }
}

class Branch {
  int? id;
  String? name;
  int? patientsCount;
  String? location;
  String? phone;
  String? mail;
  String? address;
  String? gst;
  bool? isActive;

  Branch({
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

  Branch.fromJson(Map<String, dynamic> json) {
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
