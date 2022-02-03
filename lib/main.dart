import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Member registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StepperDemo(),
    );
  }
}

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  String _selectedGender = 'male';
  String birthDateInString = '';
  late DateTime birthDate;
  var isDateSelected = false;
  TextEditingController name = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController maritalstatus = TextEditingController();
  TextEditingController occupation = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Member Registration'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue: continued,
                onStepCancel: cancel,
                steps: <Step>[

                  Step(
                    title: new Text('Applicants details:'),
                    content: Column(
                      children: <Widget>[
                        /*  surname
                      other names
                      gender
                       date of birth
                       marital status
                       occupations*/
                        TextField(
                          controller: fullname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: surname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Other Names',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Gender:'),
                              Expanded(
                                flex: 6,
                                child: ListTile(
                                  leading: Radio<String>(
                                    value: 'male',
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  ),
                                  title: const Text(
                                    'Male',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: ListTile(
                                  leading: Radio<String>(
                                    value: 'female',
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  ),
                                  title: const Text(
                                    'Female',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 16.0),
                                  dense: true,
                                ),
                              )
                         ,
                            //const SizedBox(height: 25),
                            // Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
                          ],
                        ),
                        Row(children: [
                          Text('Date of Birth'),
                          SizedBox(width: 20), // give it width
                          Text(birthDateInString != null
                              ? birthDateInString = 'Not Selected'
                              : birthDateInString),
                          SizedBox(width: 20), // give it width
                          GestureDetector(
                              child: new Icon(Icons.calendar_today),
                              onTap: () async {
                                final datePick = await showDatePicker(
                                    context: context,
                                    initialDate: new DateTime.now(),
                                    firstDate: new DateTime(1900),
                                    lastDate: new DateTime(2100));
                                if (datePick != null && datePick != birthDate) {
                                  setState(() {
                                    birthDate = datePick;
                                    isDateSelected = true;
                                    birthDateInString =
                                        "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
                                  });
                                }
                              })
                        ]),
                        SizedBox(height: 16,),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Marital Status:'),
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                  leading: Radio<String>(
                                    value: 'married',
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  ),
                                  title: const Text(
                                    'M',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 16.0),
                                  dense: true,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: ListTile(
                                  leading: Radio<String>(
                                    value: 'single',
                                    groupValue: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value!;
                                      });
                                    },
                                  ),
                                  title: const Text(
                                    'S',
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 16.0),
                                  dense: true,
                                ),
                              )

                            //const SizedBox(height: 25),
                            // Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
                          ],
                        ),
                        SizedBox(width: 16,),
                        TextField(
                          controller: fullname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Occupation',
                          ),
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Contact Details'),

                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Postal Adress',
                          )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Postal Code',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Telephone',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Cellphone',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email Address',
                          ),
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Physical Address'),

                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Location',
                          )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Street/Building/Estate',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'House Number',
                          ),
                        ),
                        SizedBox(height: 8,),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:  const Text('Home/Permanent Adress'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'P.BOX ADDRESS',
                          )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Postal Code',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Town/City',
                          ),
                        ),
                        SizedBox(height: 8,),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Identification'),

                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ID No.',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Place of Issue',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'KRA PIN',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'PASSPORT NO',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ISSUE DATE',
                          ),
                        ),
                     SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'EXPIRY DATE',
                          ),
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Next of Kin Details'),

                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Relationship',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'ID NO.',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Telephone No.',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Postal Address',
                          ),
                        ),


                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Employment Details'),

                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name of Employer',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Department',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Payroll NO.',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Station',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Location',
                          ),
                        ),
                      SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Employment No',
                          ),
                        ),
                      SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Terms of Employment',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Contract Expiry Date',
                          ),
                        ),


                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Self-Employment Details'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name of Business',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Building/Street/Estate',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Office Number',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nature of Business',
                          ),
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Source of Funds'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Salary/Business/Pension',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Building/Street/Estate',
                          ),

                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Office Number',
                          ),
                        ),
                        SizedBox(height: 8,),
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nature of Business',
                          ),
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:  Text('Estimated Monthly Income Levels:'),
                    content: Column(
                      children: <Widget>[
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Income Levels:'),
                            Expanded(
                              flex: 6,
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'lessthan20000',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                title: const Text(
                                  '0-20 000',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'btw20and50',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                title: const Text(
                                  '20 000-50 000',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                dense: true,
                              ),
                            ),
                            //const SizedBox(height: 25),
                            // Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
                          ],
                        ),


                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title: new Text('Details of Chai Angels Junior Account'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                          controller: fullname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: surname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Other Names',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Gender:'),
                            Expanded(
                              flex: 6,
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'male',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Male',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: ListTile(
                                leading: Radio<String>(
                                  value: 'female',
                                  groupValue: _selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGender = value!;
                                    });
                                  },
                                ),
                                title: const Text(
                                  'Female',
                                  style: TextStyle(fontSize: 14.0),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 16.0),
                                dense: true,
                              ),
                            )
                            ,
                            //const SizedBox(height: 25),
                            // Text(_selectedGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
                          ],
                        ),
                        Row(children: [
                          Text('Date of Birth'),
                          SizedBox(width: 20), // give it width
                          Text(birthDateInString != null
                              ? birthDateInString = 'Not Selected'
                              : birthDateInString),
                          SizedBox(width: 20), // give it width
                          GestureDetector(
                              child: new Icon(Icons.calendar_today),
                              onTap: () async {
                                final datePick = await showDatePicker(
                                    context: context,
                                    initialDate: new DateTime.now(),
                                    firstDate: new DateTime(1900),
                                    lastDate: new DateTime(2100));
                                if (datePick != null && datePick != birthDate) {
                                  setState(() {
                                    birthDate = datePick;
                                    isDateSelected = true;
                                    birthDateInString =
                                    "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
                                  });
                                }
                              })
                        ]),
                        SizedBox(width: 16,),
                        TextField(
                          controller: fullname,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Birth Certificate/Notification No.',
                          ),
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:  Text('Chai Holiday Account'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Monthly Contibution Amount',
                            )
                        ),
                        SizedBox(height: 8,),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:  Text('Deposit Contribution'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Monthly Deposit Amount',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Proposed mode of remittance-check-off/standing order/direct debit//other specify',
                            )
                        ),   TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Effective date',
                            )
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:  Text('Savings Contribution'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Monthly Savings Amount',
                            )
                        ),
                        SizedBox(height: 8,),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:  Text('Share Capital'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'No. of Shares Applied',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Amount',
                            )
                        ),    TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Monthly Contribution Amount',
                            )
                        ),

                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  Step(
                    title:  Text('Nominee(s)'),
                    content: Column(
                      children: <Widget>[
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                            )
                        ),
                        SizedBox(height: 8,),
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ID No',
                            )
                        ),
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone No.',
                            )
                        ),
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Relationship',
                            )
                        ),
                        TextField(
                            controller: name,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Address',
                            )
                        )
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),
    );
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 16 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
