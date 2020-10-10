import 'DataBase.dart';

class UserModle {
  final String uid;
  int _age;
  double _weight, _height;
  String _gender, _goal, photoUrl, name, email;
  Map<String, dynamic> _info = new Map<String, dynamic>();
  UserModle({this.uid});

  int get age => _age;
  // set age(int age) => _age = age;

  double get weight => _weight;

  String get goal => _goal;
  // set weight(double weight) => _weight = weight;

  double get height => _height;
  // set height(double height) => _height = height;

  String get gender => _gender;
  // set gender(String gender) => _gender = gender;

  Future<Map<String, dynamic>> get info async {
    if (name == null) await fetchUserInfo();
    return {
      NameDB: this.name,
      EmailDB: this.email,
      AgeDB: this._age,
      WeightDB: this._weight,
      HeightDB: this._height,
      GoalDB: this._goal,
      GenderDB: this._gender,
      PhotoUrlDB: this.photoUrl,
    };
  }

  Future<UserModle> fetchData() =>
      Future.delayed(Duration(seconds: 0), () async {
        if (name == null) await fetchUserInfo();
        print('fetch data');
        return this;
      });

  setUserHealth(
      String uid, int age, double weight, double height, String gender) async {
    this._age = age;
    this._weight = weight;
    this._height = height;
    this._gender = gender;
    if (_goal != null) setInfo();

    await setUserHealthDB(uid, age, weight, height, gender)
        .then((value) => null)
        .catchError((onError) => print('$onError'));
  }

  setUserGoal(String userUid, int goal) async {
    // 0 :  Gain
    // 1 : Maintain
    // 2 : Lose
    String goalString = '';

    switch (goal) {
      case 0:
        {
          goalString = 'Gain';
        }
        break;
      case 1:
        {
          goalString = 'Maintain';
        }
        break;
      case 2:
        {
          goalString = 'Lose';
        }
        break;
    }
    this._goal = goalString;

    await setUserGoalDB(uid, goalString);
    fetchUserInfo();
    setInfo();
  }

  //Fetch User Info From DB
  fetchUserInfo() async {
    await fetchUserInfoDB(uid).then((value) {
      value.forEach((key, value) {
        switch (key) {
          case NameDB:
            this.name = value;
            print(name);
            break;
          case EmailDB:
            this.email = value;
            break;
          case PhotoUrlDB:
            this.photoUrl = value;
            break;
          case AgeDB:
            this._age = value;
            break;
          case WeightDB:
            this._weight = value;
            break;
          case HeightDB:
            this._height = value;
            break;
          case GoalDB:
            this._goal = value;
            break;
          case GenderDB:
            this._gender = value;
            break;
        }
      });
      // name = value[NameDB];
      // email = value[EmailDB];
      // _age = int.parse(value[AgeDB]);
      // _weight = double.parse(value[WeightDB]);
      // _height = double.parse(value[HeightDB]);
      // _gender = value[GenderDB];
      // _goal = value[GoalDB];
      // photoUrl = value[PhotoUrlDB];
      print('User Date Has Been Fetched');
    }).catchError((onError) => print('Failed To Fetch $onError'));
  }

  setInfo() {
    _info.addAll({
      NameDB: this.name,
      EmailDB: this.email,
      AgeDB: this._age,
      WeightDB: this._weight,
      HeightDB: this._height,
      GoalDB: this._goal,
      GenderDB: this._gender,
      PhotoUrlDB: this.photoUrl,
    });
  }
}
