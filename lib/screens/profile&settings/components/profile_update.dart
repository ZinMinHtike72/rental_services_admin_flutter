import 'package:flutter/material.dart';
import 'package:rental_services/components/cus_input.dart';
import 'package:rental_services/components/cus_image_picker.dart';
import 'package:rental_services/components/loading_button.dart';
import 'package:provider/provider.dart';
import 'package:rental_services/providers/login_provider.dart';
import 'package:rental_services/reuseable_functions/reuseable_function.dart';
import 'package:rental_services/services/api_services.dart';
import 'package:rental_services/services/storage_services.dart';
import 'package:rental_services/components/alert_dialog.dart';
import 'package:rental_services/controller/profile_manage_controller.dart';

class Profile_Update extends StatefulWidget {
   final Map data;
   Profile_Update({Key? key,required Map this.data}) : super(key: key);
  @override
  State<Profile_Update> createState() => _Profile_UpdateState();
}

class _Profile_UpdateState extends State<Profile_Update> {
  var profileController = Profile_Manage_Controller();
  // bool status =  false;
  // String? profile;
  // String name = '';
  // String? nameError;
  @override
  void initState(){
    super.initState();
    profileController.setName( widget.data['name']);
  }
  @override
  Widget build(BuildContext context){
    // void updateProfile() async{
    //   bool nameResult = Reuseable_Function.checkIsHave(value: name);
    //   if(!nameResult){
    //     setState(() {
    //       nameError = 'Need To Fill The Name !';
    //     });
    //   }else{
    //     final Map sendData = {
    //       "name":name,
    //       'profile':profile
    //     };
    //     setState(() {
    //       status = true;
    //     });
    //    final resData = await Api_Services.postMethod(data: sendData, path: Constant_Api.profile);
    //    setState(() {
    //      status = false;
    //    });
    //    if(!resData['error']){
    //      Storage_Services.setLoginData(data: resData['data']);
    //      context.read<Login_Provider>().setLoginData(data: resData['data']);
    //      Api_Services.setLoginData(resData['data']);
    //      Alert_Dialog.Cus_Alert_Dialog(context: context, title: "Update Success !", status: 'success');
    //    }
    //   }
    // }
    return Consumer<Login_Provider>(
        builder: (context,data,child){
          return SingleChildScrollView(
            child:  Container(
              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Cus_Input(label: "Email",onChange: (data){}, value: data.loginData!['email'],enabled: false,),
                  Cus_Input(label: "User Name", onChange: (data){
                    profileController.setName(data);
                  }, value: profileController.name,errorText: data.profileUpdateNameError,),
                  SizedBox(
                    height: 10,
                  ),
                  Cus_Image_Picker(setData: (image){
                    profileController.setProfile(image);
                  }, label: "Select Profile",oldImage: data.loginData!['profile'] ?? null,),
                  SizedBox(
                    height: 10,
                  ),
                  Loading_Button(label: "Update Profile", status: data.profileUpdateStatus, loadingStatus: "Updating", onPressed: (){profileController.updateProfile(context: context);})
                ],
              ),
            ),
          );
        }
    );
  }
}
