class ServiceCategoryModel {
  final String serviceModelUID;
  final List<Service> services;
  final String servicePhoto;
  final String serviceModelName;

  ServiceCategoryModel(
      {required this.serviceModelUID,
      required this.services,
      required this.servicePhoto,
      required this.serviceModelName});

  factory ServiceCategoryModel.fromMap(Map<String, dynamic> map) {
    List<Service> services = [];

    if (map['services'] != null) {
      for (var serviceMap in map['services']) {
        services.add(Service.fromMap(serviceMap));
      }
    }

    return ServiceCategoryModel(
      serviceModelName: map['serviceModelName'],
      servicePhoto: map['servicePhoto'],
      serviceModelUID: map['serviceModelUID'],
      services: services,
    );
  }
}

class Service {
  final String servicePhoto;
  final String serviceName;
  final String serviceUID;
  final List<SubCategoryService> subCategoryServices;

  Service({
    required this.servicePhoto,
    required this.serviceName,
    required this.serviceUID,
    required this.subCategoryServices,
  });

  factory Service.fromMap(Map<String, dynamic> map) {
    List<SubCategoryService> subCategoryServices = [];

    if (map['subCategoryServices'] != null) {
      for (var subCategoryServiceMap in map['subCategoryServices']) {
        subCategoryServices
            .add(SubCategoryService.fromMap(subCategoryServiceMap));
      }
    }

    return Service(
      servicePhoto: map['servicePhoto'],
      serviceName: map['serviceName'],
      serviceUID: map['serviceUID'],
      subCategoryServices: subCategoryServices,
    );
  }
}

class SubCategoryService {
  final String subCategoryServiceName;
  final String subCategoryServiceUID;

  SubCategoryService({
    required this.subCategoryServiceName,
    required this.subCategoryServiceUID,
  });

  factory SubCategoryService.fromMap(Map<String, dynamic> map) {
    return SubCategoryService(
      subCategoryServiceName: map['subCategoryServiceName'],
      subCategoryServiceUID: map['subCategoryServiceUID'],
    );
  }
}
