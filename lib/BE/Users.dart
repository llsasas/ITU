class AppUsers {
  String? email;
  String? username;
  String? name;
  String? surname;
  String status = '';

  AppUsers(
      {required this.email,
      required this.username,
      required this.name,
      required this.surname,
     });
}

  List<AppUsers> appusers = [
    AppUsers(email: "janeruss@gmail.com",username: 'JRuss', name: "Jane",  surname: "Russel"),
    AppUsers(email: "gmurphy@gmail.com",username: 'G123', name: "Glady's",  surname: "Murphy"),
    AppUsers(email: "henryjones@gmail.com",username: 'KingHenry123', name: "Jorge",  surname: "Henry"),
    AppUsers(email: "foxxik@seznam.cz",username: 'FoxtheCreator', name: "Philip",  surname: "Fox"),
   AppUsers(email: "deborah@email.cz",username: 'deborah', name: "Debra",  surname: "Hawkins"),
    AppUsers(email: "jacobpena@gmail.com",username: 'peAndriii', name: "Andrey",  surname: "Jones"),
    AppUsers(email: "wickenzie@vut.cz",username: 'Coldwick', name: "John",  surname: "Wick"),
  ];
