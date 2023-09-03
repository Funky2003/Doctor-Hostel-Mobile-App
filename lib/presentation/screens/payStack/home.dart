import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_booking/presentation/screens/payStack/payment_page.dart';
import '../../../app/routes/app.routes.dart';
import '../../../core/models/room.model.dart';
import '../../../core/notifiers/authentication.notifier.dart';

class PayStackHomePage extends StatefulWidget {
  const PayStackHomePage({super.key});
  @override
  State<PayStackHomePage> createState() => _PayStackHomePageState();
}

class _PayStackHomePageState extends State<PayStackHomePage> {
  final _formKey = GlobalKey<FormState>();
  var amountController = TextEditingController();
  late final RoomModel roomData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<AuthenticationNotifer>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Momo Payment with paystack'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: amountController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field missing';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter the amount',
                  border: OutlineInputBorder(),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      Navigator.of(context).popAndPushNamed(
                          AppRouter.paymentRoute,
                          arguments: PaymentArgs(
                              amount: amountController.text as int,
                              email: '${'nusetorsetsofia101@gmail.com'}',
                              reference: "Doc.Hostel${DateTime.now().millisecond}${DateTime.now().microsecond}",
                              roomID: roomData.roomId,
                              userID: userData.userId!
                          )
                      );
                    },
                    child: const Text(
                      'Proceed to make payment',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
