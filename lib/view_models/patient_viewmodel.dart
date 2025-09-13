import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus/models/local/treatment_data.dart';
import 'package:noviindus/models/response_models/branch_list_response.dart';
import 'package:noviindus/models/response_models/general_response.dart';
import 'package:noviindus/models/response_models/patient_list_response.dart';
import 'package:noviindus/models/response_models/treatment_list_response.dart';
import 'package:noviindus/services/api_service/api_repository.dart';

class PatientViewmodel extends ChangeNotifier {
  final ApiRepository apiRepository;
  PatientViewmodel({required this.apiRepository});

  String? _selectedPaymentOption;

  String? get selectedPaymentOption => _selectedPaymentOption;

  void selectOption(String option) {
    _selectedPaymentOption = option;
    notifyListeners();
  }

  String? _errormsg;
  String? get errormsg => _errormsg;

  bool? _isloading = false;
  bool? get isloading => _isloading;

  //get patient list api call
  List<Patient>? _patientList;
  List<Patient>? _filteredList;

  List<Patient>? get patientList => _filteredList ?? _patientList;

  void setPatients(List<Patient>? patients) {
    _patientList = patients;
    _filteredList = patients;
    notifyListeners();
  }

  final TextEditingController searchController = TextEditingController();

  // search locally by name
  void searchPatient(String query) {
    if (query.isEmpty) {
      _filteredList = _patientList;
    } else {
      _filteredList =
          _patientList
              ?.where(
                (p) =>
                    (p.name ?? "").toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  void clearSearch() {
    _filteredList = _patientList;
    searchController.clear();
    notifyListeners();
  }

  //sort by date
  DateTime? _selectedDateFilter;
  DateTime? get selectedDateFilter => _selectedDateFilter;

  void filterByDate(DateTime date) {
    _selectedDateFilter = date;

    final dateOnly = DateFormat('yyyy-MM-dd').format(date);

    _filteredList =
        _patientList?.where((patient) {
          final createdDate = DateTime.tryParse(patient.createdAt ?? '');
          if (createdDate == null) return false;
          return DateFormat('yyyy-MM-dd').format(createdDate) == dateOnly;
        }).toList();

    notifyListeners();
  }

  void clearDateFilter() {
    _selectedDateFilter = null;
    _filteredList = _patientList;
    notifyListeners();
  }

  //get patients list

  Future<bool> getPatientList() async {
    _isloading = true;
    notifyListeners();
    clearSearch();
    try {
      PatientListResponse? response = await apiRepository.getPatientList();
      if (response?.status == true) {
        setPatients(response?.patient);
        _isloading = false;
        notifyListeners();
        return true;
      } else {
        _errormsg = response?.message ?? "";
      }
      _isloading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      _errormsg = e.toString();
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  //register patient screen

  // Controllers
  final nameController = TextEditingController();
  final whatsappController = TextEditingController();
  final addressController = TextEditingController();
  final totalAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final advanceAmountController = TextEditingController();
  final balanceAmountController = TextEditingController();
  final treatmentDateController = TextEditingController();

  // Dropdown selections
  String? selectedLocation;
  String? selectedBranch;
  int? selectedBranchID;

  addsSelectedLocation(String? val) {
    selectedLocation = val;
    notifyListeners();
  }

  addSelectedBranch(int? id, String? branch) {
    selectedBranchID = id;
    selectedBranch = branch;
    notifyListeners();
  }

  clearRegisterData() {
    nameController.clear();
    whatsappController.clear();
    addressController.clear();
    totalAmountController.clear();
    discountAmountController.clear();
    advanceAmountController.clear();
    balanceAmountController.clear();
    treatmentDateController.clear();
    selectedLocation = null;
    selectedBranch = null;
    selectedLocation = null;
    timeMin = null;
    timeHour = null;
    _selectedPaymentOption = null;
    notifyListeners();
  }

  registerPatientCalls() {
    clearTreatments();
    clearRegisterData();
    getTreatmentList();
    getBranchList();
  }

  //treatment

  List<TreatmentData>? _treatments = [];
  List<TreatmentData>? get treatments => _treatments;

  String? selectedTreatment;
  int? treatementID;
  int maleCount = 0;
  int femaleCount = 0;

  void setTreatment(String? value, int? id, {int? male, int? female}) {
    selectedTreatment = value;
    treatementID = id;
    if (male != null) {
      maleCount = male;
    }
    if (female != null) {
      femaleCount = female;
    }
    notifyListeners();
  }

  void incrementMale() {
    maleCount++;
    notifyListeners();
  }

  void decrementMale() {
    if (maleCount > 0) maleCount--;
    notifyListeners();
  }

  void incrementFemale() {
    femaleCount++;
    notifyListeners();
  }

  void decrementFemale() {
    if (femaleCount > 0) femaleCount--;
    notifyListeners();
  }

  int? editingIndex;

  void editTreatment(int index) {
    final t = _treatments![index];
    selectedTreatment = t.name;
    treatementID = t.id;
    maleCount = t.maleCount;
    femaleCount = t.femaleCount;
    editingIndex = index;
    notifyListeners();
  }

  void saveTreatment() {
    if (selectedTreatment == null || treatementID == null) return;

    final treatmentData = TreatmentData(
      id: treatementID,
      name: selectedTreatment!,
      maleCount: maleCount,
      femaleCount: femaleCount,
    );

    if (editingIndex != null) {
      // Update existing treatment
      _treatments?[editingIndex!] = treatmentData;
      editingIndex = null; // reset after edit
    } else {
      // Add new treatment
      _treatments?.add(treatmentData);
    }

    // Reset selection
    clearTreatmentData();
    notifyListeners();
  }

  void deleteTreatment(int index) {
    _treatments?.removeAt(index);
    notifyListeners();
  }

  clearTreatmentData() {
    treatementID = null;
    selectedTreatment = null;
    maleCount = 0;
    femaleCount = 0;
    notifyListeners();
  }

  clearTreatments() {
    _treatments = [];
    treatementID = null;
    selectedTreatment = null;
    maleCount = 0;
    femaleCount = 0;
    notifyListeners();
  }

  ///treatment list api

  List<Treatments>? _treatmentList;
  List<Treatments>? get treatmentList => _treatmentList;

  Future<bool> getTreatmentList() async {
    _isloading = true;
    notifyListeners();
    try {
      TreatmentListResponse? response = await apiRepository.getTreatmentList();
      if (response?.status == true) {
        _treatmentList = response?.treatments;
        _isloading = false;
        notifyListeners();
        return true;
      } else {
        _errormsg = response?.message ?? "";
      }
      _isloading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      _errormsg = e.toString();
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  ///branch list api

  List<Branches>? _branchesList;
  List<Branches>? get branchesList => _branchesList;

  Future<bool> getBranchList() async {
    _isloading = true;
    notifyListeners();
    try {
      BranchListResponse? response = await apiRepository.getBranchList();
      if (response?.status == true) {
        _branchesList = response?.branches;
        _isloading = false;
        notifyListeners();
        return true;
      } else {
        _errormsg = response?.message ?? "";
      }
      _isloading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      _errormsg = e.toString();
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  ///register patient api call

  String? timeHour;
  String? timeMin;
  DateTime? selectedDate;
  addTimeHour(String? val) {
    timeHour = val;
    notifyListeners();
  }

  addTimeMin(String? val) {
    timeMin = val;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  final registerFormKey = GlobalKey<FormState>();
  Future<bool> registerPatient() async {
    if (_treatments == null || _treatments!.isEmpty) return false;

    _isloading = true;
    notifyListeners();

    bool allSuccess = true;

    try {
      for (var t in _treatments!) {
        GeneralResponse? response = await apiRepository.registerPatient(
          data: {
            "name": nameController.text,
            "excecutive": "",
            "payment": selectedPaymentOption,
            "phone": whatsappController.text,
            "address": addressController.text,
            "total_amount": int.tryParse(totalAmountController.text),
            "discount_amount": int.tryParse(discountAmountController.text),
            "advance_amount": int.tryParse(advanceAmountController.text),
            "balance_amount": int.tryParse(balanceAmountController.text),
            "date_nd_time": formattedDateTime,
            "id": "",
            "male": t.maleCount,
            "female": t.femaleCount,
            "branch": selectedBranchID,
            "treatments": t.id,
          },
        );

        if (response?.status != true) {
          allSuccess = false;
          _errormsg = response?.message ?? "Failed to register ${t.name}";
          debugPrint(_errormsg);
        }
      }

      if (allSuccess) {
        await getPatientList();
      }

      _isloading = false;
      notifyListeners();
      return allSuccess;
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      _errormsg = e.toString();
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  String get formattedDateTime {
    if (selectedDate == null || timeHour == null || timeMin == null) {
      return "";
    }

    int hour = int.parse(timeHour!);
    final minute = int.parse(timeMin!);

    final now = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      hour,
      minute,
    );

    return DateFormat("dd/MM/yyyy-hh:mm a").format(now);
  }
}
