// category_model.dart

class Category {
  final String image;
  final String name;

  Category({
    required this.image,
    required this.name,
  });
}

List<Category> categoriesData = [
  Category(
      image: 'assets/images/plumbingRepairs.png', name: 'Plumbing Repairs'),
  Category(image: 'assets/images/electricalWork.png', name: 'Electrical Work'),
  Category(image: 'assets/images/painting.png', name: 'Painting'),
  Category(image: 'assets/images/Carpentry.png', name: 'Carpentry'),
  Category(
      image: 'assets/images/applianceInstallation.png',
      name: 'Appliance Installation/Repair'),

  Category(
      image: 'assets/images/furnitureAssembly.png', name: 'Furniture Assembly'),
  Category(image: 'assets/images/gardening.png', name: 'Gardening'),
  Category(
      image: 'assets/images/generalMaintenance.png',
      name: 'General Home Maintenance'),
  Category(
      image: 'assets/images/tilingFlooring.png',
      name: 'Tiling and Flooring Installation/Repair'),
  Category(
      image: 'assets/images/hvacMaintenance.png', name: 'Air/HVAC Maintenance'),
  Category(image: 'assets/images/roofingRepairs.png', name: 'Roofing Repairs'),
  Category(
      image: 'assets/images/windowDoor.png',
      name: 'Window and Door Repairs/Installation'),
  Category(
      image: 'assets/images/interiorDesign.png',
      name: 'Interior Design Consultation'),
  Category(
      image: 'assets/images/pestControl.png', name: 'Pest Control Services'),
  Category(
      image: 'assets/images/cctvInstallation.png', name: 'CCTV Installation'),
  // Category(image: 'assets/images/weldingMetalwork.png', name: 'Welding and Metalwork'),
  // Category(image: 'assets/images/plasteringDrywall.png', name: 'Plastering and Drywall Repair'),
  // Category(image: 'assets/images/homeCleaning.png', name: 'Home Cleaning Services'),
  // Category(image: 'assets/images/locksmith.png', name: 'Locksmith Services'),
  // Category(image: 'assets/images/securitySystemInstallation.png', name: 'Home Security System Installation'),
  // Category(image: 'assets/images/ceilingFan.png', name: 'Ceiling Fan Installation/Repair'),
  // Category(image: 'assets/images/drainageMaintenance.png', name: 'Drainage System Maintenance'),
  // Category(image: 'assets/images/exteriorPainting.png', name: 'Exterior Painting'),
  // Category(image: 'assets/images/deckPatio.png', name: 'Deck or Patio Construction/Repairs'),
  // Category(image: 'assets/images/fenceInstallation.png', name: 'Fence Installation/Repair'),
  // Category(image: 'assets/images/waterproofingBasements.png', name: 'Waterproofing Basements'),
  // Category(image: 'assets/images/lightFixture.png', name: 'Light Fixture Installation/Replacement'),
  // Category(image: 'assets/images/mirrorArtwork.png', name: 'Mirror and Artwork Hanging'),
  // Category(image: 'assets/images/powerWashing.png', name: 'Power Washing Services'),
  // Category(image: 'assets/images/homeTheater.png', name: 'Home Theater System Setup'),
];
