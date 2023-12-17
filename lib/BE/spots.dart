const String desc = "In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero. Pellentesque ipsum. Aenean id metus id velit ullamcorper pulvinar. Mauris metus. Donec iaculis gravida nulla. Nunc dapibus tortor vel mi dapibus sollicitudin. Et harum quidem rerum facilis est et expedita distinctio. Integer imperdiet lectus quis justo. In enim a arcu imperdiet malesuada. In rutrum.:";

class Spot
{
  final String name;
  String? address;
  final String description;
  List<String> picturelinks;
  num? level;
  Spot({required this.name, required this.address, required this.description, required this.level, required this.picturelinks});
}

List<Spot> spotslist =
[
  Spot(name: "Moravská zemská knihovna", address: "Kounicova 65a, 601 87 Brno-střed", description: desc, level: 3, picturelinks: ["Moravská zemská knihovna/6.jpg","Moravská zemská knihovna/8.jpg"]),
  Spot(name: "Hlavas", address: "Benešova 612/22, 602 00 Brno-střed", description: desc, level: 2,picturelinks: ["Hlavas/ds.jpg", "Hlavas/kravihora.jpg", "Hlavas/sokol.jpg", "Hlavas/spot.jpg"]),
  Spot(name: "Náměstí Míru", address: "nám. Míru 377, 602 00 Brno-střed-Stránice", description: desc, level: 1, picturelinks: ["Naměstí Míru/1.jpg", "Naměstí Míru/2.jpg"]),
  Spot(name: "Orel Řečkovice", address: "Veselka 21, 621 00 Brno-Řečkovice a Mokrá Hora", description: desc, level: 3, picturelinks: ["Orel Řečkovice/3.jpg", "Orel Řečkovice/4.jpg"]),
  Spot(name: "Plachťák", address: "Sportovně rekreační areál Park Pod Plachtami, 637 00 Brno-Nový Lískovec", description: desc, level: 1,picturelinks: ["Plachťák/5.jpeg"]),
  Spot(name: "Chrlice", address: "Blümlova 783/21, 643 00 Brno-Chrlice", description: desc, level: 1, picturelinks: ["Chrlice/colo.jpg", "Chrlice/dsds.jpg", "Chrlica/spota.jpg"]),
];
