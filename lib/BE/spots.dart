const String desc = "In laoreet, magna id viverra tincidunt, sem odio bibendum justo, vel imperdiet sapien wisi sed libero. Pellentesque ipsum. Aenean id metus id velit ullamcorper pulvinar. Mauris metus. Donec iaculis gravida nulla. Nunc dapibus tortor vel mi dapibus sollicitudin. Et harum quidem rerum facilis est et expedita distinctio. Integer imperdiet lectus quis justo. In enim a arcu imperdiet malesuada. In rutrum.:";

class Spot
{
  final String name;
  String? address;
  final String description;
  num? level;
  Spot({required this.name, required this.address, required this.description, required this.level});
}

List<Spot> spotslist =
[
  Spot(name: "Moravská zemská knihovna", address: "Kounicova 65a, 601 87 Brno-střed", description: desc, level: 3),
  Spot(name: "Hlavas", address: "Benešova 612/22, 602 00 Brno-střed", description: desc, level: 2),
  Spot(name: "Naměstí Míru", address: "nám. Míru 377, 602 00 Brno-střed-Stránice", description: desc, level: 1),
  Spot(name: "Orel Řečkovice", address: "Veselka 21, 621 00 Brno-Řečkovice a Mokrá Hora", description: desc, level: 3),
  Spot(name: "Santon", address: "Veselka 21, 621 00 Brno-Řečkovice a Mokrá Hora", description: desc, level: 3),
  Spot(name: "Plachťák", address: "Sportovně rekreační areál Park Pod Plachtami, 637 00 Brno-Nový Lískovec", description: desc, level: 1),
  Spot(name: "Olympia", address: "U Dálnice 744, 664 42 Modřice", description: desc, level: 3),
  Spot(name: "Chrlice", address: "Blümlova 783/21, 643 00 Brno-Chrlice", description: desc, level: 1),
];
