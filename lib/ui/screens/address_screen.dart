import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/ui/screens/add_location_screen.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddressScreen extends StatefulWidget {
  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
        brightness: Brightness.light,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRegular('Addresses', TextAlign.start),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          //region address list
          child: FutureBuilder(
            future: readJson("URL", "addressData"),
            builder: (BuildContext context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    AddressModel addressModel = snapshot.data[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.0,
                          color: ColorResources.smokeWhiteColor,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(7.0)),
                        color: ColorResources.smokeWhiteColor,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.home,
                            color: ColorResources.dodgerBlueColor,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textBold(addressModel.field.toString(), TextAlign.start),
                              SizedBox(
                                height: 10.0,
                              ),
                              textRegular(addressModel.address != null ? addressModel.address : "", TextAlign.start),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            width: 10.0,
                          ),
                          // InkWell(
                          //     onTap: () {},
                          //     child: Icon(
                          //       Icons.edit,
                          //       color: ColorResources.dodgerBlueColor,
                          //     )),
                          // SizedBox(
                          //   width: 10.0,
                          // ),
                          InkWell(
                              onTap: () async {
                                await pr.show();
                                setState(() {
                                  snapshot.data.removeAt(index);
                                });
                                await pr.hide();
                              },
                              child: Icon(
                                Icons.delete_forever_rounded,
                                color: ColorResources.heartColor,
                              )),
                        ],
                      ),
                    );
                  },
                );
              }
              else if(snapshot.hasError){
                return Center(child: textBold("${snapshot.error}", TextAlign.start));
              }

              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            },
          ),
          //endregion
        ),
      ),

      //region button to add address
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddLocationScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.add,
            color: ColorResources.whiteColor,
          ),
          label: Text(
            "Add Address",
            style: TextStyle(
              fontSize: 16,
              color: ColorResources.whiteColor,
              fontFamily: FontResources.bold,
            ),
          ),
          backgroundColor: ColorResources.dodgerBlueColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //endregion
    );
  }
}
