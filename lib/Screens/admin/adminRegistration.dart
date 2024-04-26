import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_school/Screens/Authentication/authenticate.dart';
import 'package:flutter_school/services/database.dart';

class RegistrationScreen extends StatefulWidget {
  final Function(int)? onStudentTap;
  const RegistrationScreen({
    Key? key,
    this.onStudentTap,
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService authService = AuthService();
  final DatabaseService database = DatabaseService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  String _selectedUserType = 'parent'; // Default user type
  String _selectedDistrict = 'Belize'; // This will be set in initState
  String _selectedSchool =
      'ABC Preschool'; // This will be set in initState based on the selected district
  List<String> _districts = [
    'Belize',
    'Cayo',
    'Corozal',
    'Orange Walk',
    'Stann Creek',
    'Toledo'
  ];
  Map<String, List<String>> _schools = {
    'Belize': [
      'ABC Preschool',
      'Anglican Diocesan Preschool',
      'Belize Elementary School',
      'Bernice Yorke Institute of Learning',
      'Bethany Baptist preschool',
      'Brighter Tomorrow Preschool',
      'Building Block Pre School',
      'Central Christian Preschool',
      'Church of Christ Preschool',
      'City Early Childhood Education Center',
      'Crooked Tree Government Preschool',
      'Ebanks Preschool',
      'Eternal Light Methodist Preschool',
      'Ethel Vargas Community Preschool',
      'Hand in Hand Ministries Preschool',
      'Harmony Preschool',
      'Hattieville Government Preschool',
      'Helping Hands',
      'Holy Cross Anglican',
      'Horizon Academy',
      'Hummingbird Elementary',
      'James Garbutt Pre School',
      'Kiddies Campus',
      'La Isla Carinosa Academy',
      'Liberty Community Preschool',
      'Little Angels Preschool',
      'Little Star Preschool',
      'Lloyd Coffin Preschool',
      'Mustard Seed Preschool',
      'Our Lady of Lourdes RC Preschool',
      'Pilgrim Fellowship School',
      'Pine Street Community Preschool',
      'Port Loyola Preschool',
      'San Pedro Preschool',
      "San Pedro's Shining Stars Preschool",
      'Sandhill Community Preschool',
      'Small World Baptist Preschool',
      'St. Agnes Anglican School',
      'St. Martin De Porres Preschool',
      'Star Brite Preschool',
      'Stepping Stones Preschool',
      'Sunflower Preschool',
      'Sunshine Stimulation Center',
      'Unity Star Child',
      'Wesley Preschool',
      "Young Women's Christian Association Preschool"
    ],
    'Cayo': [
      'A to Z Learning Tree Preschool',
      "All God's Children Preschool",
      'Armenia Development Preschool',
      'Arms of Love Preschool',
      'Belize Christian Academy',
      'Belmopan Community Preschool',
      'Benque Community Preschool',
      'Billy White Government Preschool',
      'Bullet Tree Community Preschool',
      'Cinderella Preschool',
      'Cristo Rey RC Preschool',
      'DePickni Place Preschool',
      'Eden SDA Preschool',
      'El Shaddai SDA Preschool',
      'Esperanza Community Preschool',
      'Garden City Preschool',
      'Hope Presbyterian Preschool',
      'Howard Smith Nazarene Preschool',
      'Judy Diego Government Preschool',
      "Kiddie’s Care Learning Center",
      'Kuxlin Ha Government Preschool',
      'La Inmaculada RC Preschool',
      'Leta Webb Preschool',
      'Miracle Angels Preschool',
      'Monrad Metzgen Government Preschool',
      'Mount Carmel Preschool',
      'Myrtle Banner Government Preschool',
      "Rosado's Preschool",
      'San Antonio Community Preschool',
      'San Ignacio Preschool',
      'Santa Cruz Government Preschool',
      'Santa Elena Baptist Preschool',
      'Santiago Juan Community Preschool',
      "St. Andrew's Anglican Preschool",
      "St. Hilda's Anglican Preschool",
      'St. Joseph Preschool',
      "St. Margaret Mary RC Preschool",
      "St. Matthew's Government Preschool",
      'St. Michael RC Preschool',
      'St. Oscar Romero RC Preschool',
      'St. Vincent Pallotti RC Preschool',
      'The Shepherds Academy Preschool',
      'University of Belize Preschool',
      'Victorious Nazarene Preschool'
    ],
    'Corozal': [
      'Buena Vista RC Preschool',
      'Calcutta Government School',
      'Caledonia R.C. Preschool',
      'Chan Chen Government Preschool',
      'Christian Assemblies of God Preschool',
      'Christiline Gill S.D.A.',
      'Chunox R.C. Preschool',
      'Chunox S.D.A. Preschool',
      'Concepcion Presbyterian Preschool',
      'Concepcion R.C. Preschool',
      'Copper Bank R.C. Preschool',
      'Corozal Church of Christ',
      'Corozal Nazarene Preschool',
      'Cristo Rey Presbyterian Preschool',
      'Cristo Rey R.C. Preschool',
      'Kiddy Kinder Preschool',
      'Libertad Methodist Preschool',
      'Louisville R.C. Preschool',
      'Mary Hill R.C. Preschool',
      'Our Lady of Guadalupe R.C. Preschool',
      'Paraiso Sunshine Government Preschool',
      'Patchakan R.C. Preschool',
      'Play World Methodist Preschool',
      'Ranchito Government Preschool',
      'Redeemer Presbyterian Preschool',
      'San Antonio Government Preschool',
      'San Joaquin R.C. Preschool',
      'San Narciso R.C. Preschool',
      'San Pedro Government Preschool',
      'San Victor R.C. Preschool',
      'Santa Clara Baptist',
      'Sarteneja Community Preschool',
      'Sarteneja La Inmaculada Preschool',
      'Sarteneja Nazarene Preschool',
      'St. Francis Xavier R.C. Preschool',
      'Xaibe R.C. Preschool'
    ],
    'Orange Walk': [
      'All God’s Children Preschool',
      'August Pine Ridge Preschool',
      'Carmelita Government Preschool',
      'Carmen’s Preschool',
      'Chan Pine Ridge Government Preschool',
      'Eden Preschool',
      'Emmanuel Presbyterian Preschool',
      'Guardian Angels Preschool',
      'Guinea Grass Pentecostal Preschool',
      'La Inmaculada Preschool',
      'Little Haven SDA Preschool',
      'Louisiana Government Preschool',
      'New Life Presbyterian Preschool',
      'Pete Lizarraga Preschool',
      'RHK Preparatory School',
      'Rising Star Preschool',
      'Saint Michael Preschool',
      'Saint Peter’s Anglican Preschool',
      'San Francisco Preschool',
      'San Jose Government Preschool',
      'San Jose Nuevo Palmar Preschool',
      'Santa Martha Preschool',
      'Santa Teresa Preschool',
      'Trial Farm Government Preschool',
      'Yo Creek Community Preschool'
    ],
    'Stann Creek': [
      'Alexia M. Nolberto',
      'Bella Vista Government Preschool',
      'Church of Christ',
      'Coastland Academy',
      'Destiny Preschool',
      'Epworth Methodist Preschool',
      'Evershine Preschool',
      'Fabian Cayetano Preschool',
      'Gales Point Government Preschool',
      'Gulisi Community Preschool',
      'Holy Angels RC School',
      'Holy Family RC Preschool',
      'Holy Ghost School',
      'Hope Creek Methodist Preschool',
      'Independence Nazarene Pre school',
      'Kids First',
      'Light of the Valley',
      'Maya Mopan Primary School',
      'Moriah Learning Center',
      'Nazarene Bright Start Preschool',
      'Our Lady of Bella Vista R.C School',
      'Peninsula International Academy',
      'Pomona Hope Preschool',
      'Red Bank Christian Preschool',
      'Richard Quinn R.C.',
      'San Isidro Government',
      'San Juan Bosco RC',
      'Santa Cruz Sunrise Preschool',
      'Silk Grass Methodist School',
      'Sittee River Methodist preschool',
      'Solid Rock Christian Academy Preschool',
      'St. Augustine R. C. School',
      'St. John\'s Momorial Anglican Preschool',
      'St. Jude R. C Preschool',
      'St. Matthew\'s Anglican Preschool',
      'St.Alphonsus',
      'Trio Government Preschool',
      'United Community Preschool'
    ],
    'Toledo': [
      'Big Falls RC Preschool',
      'Blue Creek RC Preschool',
      'Bright Star Preschool',
      'Golden Star Preschool',
      'Happy Home Preschool',
      'Little Haven RC Preschool',
      'Midway Government Preschool',
      'Our Lady of Sorrows RC preschool',
      'Progressive Early Learning Center',
      'Pueblo Viejo R.C. Preschool',
      'Sacred Heart Barry Jones Preschool',
      'San Antonio Christian Preschool',
      'San Benito Poite Preschool',
      'San Jose Preschool',
      'San Miguel R.C Preschool',
      'San Pedro Columbia Preschool',
      'Santa Teresa Preschool',
      'Silver Creek Preschool',
      'St. Joseph Anglican Preschool',
      'St. Peter Claver Preschool',
      'Sunrise Preschool',
      'Sunshine Preschool',
      'Tiny Tots Adventist Preschool',
      'Toledo Christian Academy Belize',
      'Twinkle Star Preschool'
    ],
  };

  List<String> _childrenNames = ['']; // List to store children's names
  int _childrenCount = 1;

  @override
  void initState() {
    super.initState();
    // Set the default district to the first item in the _districts list
    _selectedSchool =
        _schools[_selectedDistrict]?.first ?? 'Default School Name';
    _passwordController.text = "123456"; // Set default password
    _passwordController.addListener(() {
      // Ensure that the password remains constant
      if (_passwordController.text != "123456") {
        _passwordController.text = "123456";
      }
      _passwordController.selection = TextSelection.fromPosition(
          TextPosition(offset: _passwordController.text.length));
    });
  }

  Future<void> _register() async {
    try {
      final String name = _nameController.text.trim();
      final String email = _emailController.text.trim();
      final String userType = _selectedUserType;
      final String district = _selectedDistrict;
      final String school = _selectedSchool;

      // Collect children names only if user type is 'Parent'
      final List<String> childrenNames = _selectedUserType == 'Parent'
          ? _childrenNames.where((name) => name.isNotEmpty).toList()
          : [];

      // Await the registration operation to complete
      UserCredential? userCredential =
          await authService.register(email, _passwordController.text, name);

      if (userCredential != null) {
        // If registration was successful, save user to Firestore
        await database.saveNewUser(userCredential, name, email, userType,
            district, school, childrenNames);
        // Navigate to the next screen after successful registration
        Navigator.pushReplacementNamed(context, '/teacher');
      } else {
        // Handle case where registration failed
        throw Exception('User registration failed');
      }
    } catch (e) {
      // Handle registration errors here
      print('Registration failed: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text(
                'An error occurred during registration. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(
        // Using SingleChildScrollView to avoid overflow when the keyboard is displayed
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 8.0),
            DropdownButtonFormField<String>(
              value: _selectedUserType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedUserType = newValue!;
                });
              },
              items: <String>['parent', 'teacher', 'admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value[0].toUpperCase() +
                      value.substring(1)), // Capitalize the first letter
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'User Type',
              ),
            ),
            SizedBox(height: 8.0),
            if (_selectedUserType == 'parent') ...[
              for (int i = 0; i < _childrenCount; i++)
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    onChanged: (value) {
                      if (_childrenNames.length > i) {
                        _childrenNames[i] = value;
                      } else {
                        _childrenNames.add(value);
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Child ${i + 1} Name',
                      hintText: 'Enter child\'s name',
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _childrenCount++;
                    _childrenNames.add(
                        ''); // Add an empty string to represent a new child name entry
                  });
                },
                child: Text('Add Child'),
              ),
              SizedBox(height: 8.0),
            ],
            if (_selectedUserType == 'teacher') ...[
              DropdownButtonFormField<String>(
                value: _selectedDistrict,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDistrict = newValue!;
                    _selectedSchool = _schools[newValue]!
                        .first; // Ensuring we pick the first school of the new district
                  });
                },
                items: _districts.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'District',
                ),
              ),
              SizedBox(height: 8.0),
              DropdownButtonFormField<String>(
                value: _selectedSchool,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSchool = newValue!;
                  });
                },
                items: _schools[_selectedDistrict]!
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'School',
                ),
              ),
              SizedBox(height: 8.0),
            ],
            ElevatedButton(
              onPressed: () {
                _register;
                widget.onStudentTap!(2);
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
