import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/delivery_detail_body_model.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/pages/home/home_page.dart';
import 'package:lcmobileapp/route/route_helper.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/app_icon.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:lcmobileapp/widgets/cargo_direct_widget.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:timelines/timelines.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SecondWeightDetailPage extends StatefulWidget {
  int pageId;
  SecondWeightDetailPage({super.key, required this.pageId});

  @override
  State<SecondWeightDetailPage> createState() => _SecondWeightDetailPageState();
}

class _SecondWeightDetailPageState extends State<SecondWeightDetailPage> {
  int _currentIndex = 0;
  int _netWeight = 0;
  var weightController = TextEditingController();
  var remarkController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    weightController.addListener(() {
      weightController.text;
    });
    super.initState();
    _netWeight = 0;
  }

  @override
  void dispose() {
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeliveryDetailModel _deliveryDetail =
        Get.find<DeliveryDetailController>().pendingTicketList[widget.pageId];

    var f = NumberFormat(AppContants.FORMAT_NUMER);
    var vehiclePrimaryId = _deliveryDetail.vehiclePrimaryId ?? "";
    var vehicleSecondaryId = _deliveryDetail.vehicleSecondaryId ?? "";

    String formatDateTime(String weightTime) {
      var outputDate = DateTime.now().toString();

      DateTime parseDate =
          DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(weightTime);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat(AppContants.DATE_FORMAT2);
      outputDate = outputFormat.format(inputDate);

      return outputDate;
    }

    void onTextChanged(String text) {
      int result = 0;
      if (text.isEmpty) {
        result = 0;
      } else {
        if (!GetUtils.isNum(text)) {
          result = 0;
        } else if (_deliveryDetail.cargoDirection == AppContants.UNLOADING ||
            _deliveryDetail.cargoDirection == AppContants.STORAGE_EXPORT) {
          result = int.parse(text) -
              int.parse(_deliveryDetail.tareWeight.toString());
        } else {
          result = int.parse(_deliveryDetail.grossWeight.toString()) -
              int.parse(text);
        }
      }
      setState(() {
        _netWeight = result;
      });
    }

    void getImgFromGallary() async {
      try {
        final image =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          if (image != null) {
            print(image.path);
            // save image into ticket here
          }
        });
      } on PlatformException catch (e) {
        print("Failed to pick image: $e");
      }
    }

    void getImgFromCamera() async {
      try {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        setState(() {
          if (image != null) {
            print(image.path);
            // save image into ticket here
          }
        });
      } on PlatformException catch (e) {
        print("Failed to pick image: $e");
      }
    }

    void updateWeightNumber() {
      String number = weightController.text.trim();
      String remark = remarkController.text.trim();
      if (number.isEmpty) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE1,
            title: AppMessage.WEIGHT_INPUT);
      } else if (!GetUtils.isNum(number)) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE2,
            title: AppMessage.WEIGHT_INPUT);
      } else if (remark.length > 30) {
        showCustomSnackBar(AppMessage.ERROR_MESSAGE3,
            title: AppMessage.WEIGHT_INPUT);
      } else {
        String cargoDirection = _deliveryDetail.cargoDirection!;
        late DeliveryDetailBody deliveryDetailBody;
        if (cargoDirection == AppContants.LOADING ||
            cargoDirection == AppContants.STORAGE_IMPORT) {
          // Loading hoặc import thì cân chốt là empty
          deliveryDetailBody = DeliveryDetailBody(
              grossWeight: 0,
              remark: remark,
              tareScaleId: "",
              grossScaleId: "",
              tareWeight: int.parse(number));
        } else if (cargoDirection == AppContants.UNLOADING ||
            cargoDirection == AppContants.STORAGE_EXPORT) {
          // dỡ hàng hoặc xuất kho thì cân chốt là gross
          deliveryDetailBody = DeliveryDetailBody(
              grossWeight: int.parse(number),
              remark: remark,
              tareScaleId: "",
              grossScaleId: "",
              tareWeight: 0);
        }

        Get.find<DeliveryDetailController>()
            .updateWeight(deliveryDetailBody, _deliveryDetail.id.toString())
            .then((status) {
          if (status.isSuccess) {
            Get.to(() => const HomePage(), arguments: "FirstWeight");
            Get.snackbar(AppMessage.WEIGHT_OUT, AppMessage.SUCCESS_MESSAGE1);
          } else {
            TokenTimeOut _tokenTimeout =
                Get.find<DeliveryDetailController>().tokenTimeOut;
            if (_tokenTimeout.isTimeOut) {
              Get.find<UserController>().clearSharedData();
              Get.offNamed(RouteHelper.getLoginPage());
              Get.snackbar("Token", "Token is expired. Please login again!");
            } else {
              Get.snackbar(AppMessage.WEIGHT_OUT, status.message);
            }
          }
        });
      }
    }

    void _showModalBottomSheet(context) {
      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.radius15),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext context) {
          return Container(
            height: Dimensions.height50 * 4,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: SingleChildScrollView(
              child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width15, right: Dimensions.width15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              iconSize: Dimensions.iconSize24,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height45,
                        width: Dimensions.width20 * 18,
                        child: ElevatedButton(
                          onPressed: () {
                            getImgFromCamera();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(AppColor.mainColor),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    side:
                                        BorderSide(color: AppColor.mainColor))),
                          ),
                          child: BigText(
                            text: AppMessage.TAKE_PICTURE,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      GestureDetector(
                        onTap: () {
                          getImgFromGallary();
                        },
                        child: BigText(
                          text: AppMessage.CHOOSE_IMAGE_FROM_LIBRARY,
                          size: Dimensions.fontSize20,
                          color: AppColor.mainColor,
                        ),
                      )
                    ],
                  )),
            ),
          );
        },
      );
    }

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColor.backgroundWhiteColor,
        appBar: AppBar(
          leading: BackButton(
            color: AppColor.mainColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: BigText(
            text: AppMessage.WEIGHT_OUT,
            color: AppColor.mainColor,
            size: Dimensions.fontSize25,
          ),
          backgroundColor: AppColor.backgroundWhiteColor,
          elevation: 0,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            unselectedLabelColor: AppColor.backgroundColor,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: [
              Tab(
                // tab chi tiết
                icon: AppIcon(
                  icon: Icons.info_outline,
                  iconColor:
                      _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.DETAIL_TAB,
                    size: Dimensions.fontSize14,
                    color:
                        _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              // Phiếu cân
              Tab(
                icon: AppIcon(
                  icon: Icons.airplane_ticket,
                  iconColor:
                      _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.WEIGHT_TICKET,
                    size: Dimensions.fontSize14,
                    color:
                        _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              // Cân chốt
              Tab(
                icon: AppIcon(
                  icon: Icons.scale_outlined,
                  iconColor:
                      _currentIndex == 2 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.WEIGHT_OUT,
                    size: Dimensions.fontSize14,
                    color:
                        _currentIndex == 2 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              // Trình tự cân (Timelines)
              Tab(
                icon: AppIcon(
                  icon: Icons.list_sharp,
                  iconColor:
                      _currentIndex == 3 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.TIMELINES,
                    size: Dimensions.fontSize14,
                    color:
                        _currentIndex == 3 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              // Lịch sử bì
              Tab(
                icon: AppIcon(
                  icon: Icons.history,
                  iconColor:
                      _currentIndex == 4 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize25,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: AppMessage.HISTORY_TAB,
                      size: Dimensions.fontSize14,
                      color:
                          _currentIndex == 4 ? AppColor.mainColor : Colors.grey,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // nội dung tab chi tiết
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tầu-sà lan
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.VESSEL_BARGE,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.vesselCode ?? "",
                            size: Dimensions.fontSize14,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          BigText(
                            text: "- ${_deliveryDetail.bargeCode ?? ""}",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  // Xe / mooc
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.VEHICLE_MOOC,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.vehiclePrimaryCode ?? "",
                            size: Dimensions.fontSize14,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                          BigText(
                            text:
                                " / ${_deliveryDetail.vehicleSecondaryCode ?? ""}",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  // Chủ hàng / Đại diện
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.CONSIGNEE_DELEGATE,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text:
                                "${_deliveryDetail.manifestConsigneeCode} / ${_deliveryDetail.manifestDelegateCode ?? ""}",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  // Bên nhận / Ủy thác
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.RECEIVE_DELEGATE,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text:
                                "${_deliveryDetail.consigneeCode} / ${_deliveryDetail.delegateCode ?? ""}",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  // Loại hàng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.CARGO_CODE,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.cargoName ?? "",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  // Vận đơn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.BILLOFLANGDING,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.billOfLading ?? "",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  // Vận đơn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.SERVICE,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.serviceTypeName ?? "",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),

                  // Hướng hàng
                  CargoDirectWiget(
                      cargoDirectId: _deliveryDetail.cargoDirection ?? ""),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  //Điểm khai thác
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.OPERATION_TERMINAL,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.operationTerminalName ?? "",
                            size: Dimensions.fontSize14,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  //Hàng còn lại
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.REMAIN_CARGO,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text:
                                "${f.format(int.parse(_deliveryDetail.remainQuantity ?? "0"))} (Kg)",
                            size: Dimensions.fontSize16,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  //Cân bì hoặc cân cả hàng phụ thuộc vào hướng hàng của phiếu cân
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: (_deliveryDetail.cargoDirection ==
                                    AppContants.UNLOADING ||
                                _deliveryDetail.cargoDirection ==
                                    AppContants.STORAGE_EXPORT)
                            ? AppMessage.TARE_WEIGHT
                            : AppMessage.GROSS_WEIGHT,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: (_deliveryDetail.cargoDirection ==
                                        AppContants.UNLOADING ||
                                    _deliveryDetail.cargoDirection ==
                                        AppContants.STORAGE_EXPORT)
                                ? "${f.format(int.parse(_deliveryDetail.tareWeight ?? "0"))} (Kg) ${AppMessage.AT} ${formatDateTime(_deliveryDetail.tareTime.toString())}"
                                : "${f.format(int.parse(_deliveryDetail.grossWeight ?? "0"))} (Kg) ${AppMessage.AT} ${formatDateTime(_deliveryDetail.grossTime.toString())}",
                            size: Dimensions.fontSize16,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                ],
              ),
            ),
            // Nội dung phiếu cân
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10,
                  bottom: Dimensions.height10),
              height: Dimensions.height50,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: Dimensions.height10,
                        left: Dimensions.width10,
                        right: Dimensions.width10),
                    child: SizedBox(
                      height: Dimensions.height45,
                      width: Dimensions.screenWidth - Dimensions.height20,
                      child: ElevatedButton(
                        onPressed: () {
                          _showModalBottomSheet(context);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.mainColor),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius15),
                                  side: BorderSide(color: AppColor.mainColor))),
                        ),
                        child: BigText(
                          text: AppMessage.ADD_IMAGE,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Nội dung cân chốt
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height10),
                child: Column(children: [
                  Container(
                    height: Dimensions.height50 * 4.5,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.radius15 / 3),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/no_data.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  //Hàng còn lại
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.REMAIN_CARGO,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text:
                                "${f.format(int.parse(_deliveryDetail.remainQuantity ?? "0"))} (Kg)",
                            size: Dimensions.fontSize16,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  //Cân bì
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: (_deliveryDetail.cargoDirection ==
                                    AppContants.UNLOADING ||
                                _deliveryDetail.cargoDirection ==
                                    AppContants.STORAGE_EXPORT)
                            ? AppMessage.TARE_WEIGHT
                            : AppMessage.GROSS_WEIGHT,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: (_deliveryDetail.cargoDirection ==
                                        AppContants.UNLOADING ||
                                    _deliveryDetail.cargoDirection ==
                                        AppContants.STORAGE_EXPORT)
                                ? "${f.format(int.parse(_deliveryDetail.tareWeight ?? "0"))} (Kg)"
                                : "${f.format(int.parse(_deliveryDetail.grossWeight ?? "0"))} (Kg)",
                            size: Dimensions.fontSize16,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),
                  //Hàng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SmallText(
                        text: AppMessage.NET_WEIGHT,
                        size: Dimensions.fontSize16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: "${f.format(_netWeight)} (Kg)",
                            size: Dimensions.fontSize16,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: Dimensions.screenWidth,
                    height: 1.2,
                    margin: const EdgeInsets.only(top: 0),
                    color: AppColor.lineColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),

                  Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width10 / 5,
                        right: Dimensions.width10 / 5),
                    child: Column(
                      children: [
                        // nhập số cân
                        TextFormField(
                          controller: weightController,
                          onChanged: (value) {
                            onTextChanged(value);
                          },
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: Dimensions.width10,
                                horizontal: Dimensions.width10),
                            hintText: AppMessage.INPUT_WEIGHT_NUMBER,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius15),
                            ),
                            prefixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  weightController.text = "";
                                });
                                onTextChanged('');
                              },
                              child: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        // ghi chú
                        EditBoxWidget(
                          hint: AppMessage.REMARK,
                          controller: remarkController,
                          showClearIcon: true,
                        ),

                        // chấp nhận
                        Container(
                          margin: EdgeInsets.only(
                              top: Dimensions.height10,
                              left: Dimensions.width10,
                              right: Dimensions.width10),
                          child: SizedBox(
                            height: Dimensions.height45,
                            width: Dimensions.screenWidth - Dimensions.height20,
                            child: ElevatedButton(
                              onPressed: () {
                                updateWeightNumber();
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    AppColor.mainColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15),
                                        side: BorderSide(
                                            color: AppColor.mainColor))),
                              ),
                              child: BigText(
                                text: AppMessage.ACCEPT,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
            // Nội dung tab trình tự
            Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height10),
                child: Timeline.builder(
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return TimelineTile(
                      oppositeContents: Padding(
                        padding: EdgeInsets.only(
                          left: Dimensions.width10,
                          right: Dimensions.width10,
                        ),
                        child: BigText(
                          text: '16:34 - 25/09',
                          size: Dimensions.fontSize14,
                        ),
                      ),
                      contents: Card(
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.width10),
                          height: 100,
                          child: const Text(
                            'W.TARE - Tally cân bì 13,240 (Kg) - bởi canlemon Remark: Xe có dấu hiệu làm bì',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 20,
                          ),
                        ),
                      ),
                      node: TimelineNode(
                        indicator: DotIndicator(
                          color: AppColor.mainColor,
                        ),
                        startConnector: SolidLineConnector(
                          color: AppColor.lineColor,
                        ),
                        endConnector: SolidLineConnector(
                          color: AppColor.lineColor,
                        ),
                      ),
                    );
                  }),
                )),
            // Nội dung tab lịch sử bì
            Container(
              color: AppColor.backgroundWhiteColor,
              margin: EdgeInsets.only(
                  top: Dimensions.height20,
                  left: Dimensions.width10,
                  right: Dimensions.width10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: Dimensions.height10 / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.TARE_WEIGHT,
                              size: Dimensions.fontSize16,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.GROSS_WEIGHT,
                              size: Dimensions.fontSize16,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.WEIGHT_TIME,
                              size: Dimensions.fontSize16,
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<DeliveryDetailController>(
                      builder: (deliveryDetailController) {
                        deliveryDetailController.getHistoryWeight(
                            vehiclePrimaryId, vehicleSecondaryId);

                        Widget timeWidget(int index) {
                          var outputDate = DateTime.now().toString();
                          if (index <
                              deliveryDetailController
                                  .historyWeightList.length) {
                            DateTime parseDate =
                                DateFormat(AppContants.SQL_DATETIME_FORMAT)
                                    .parse(deliveryDetailController
                                        .historyWeightList[index].grossTime!);
                            var inputDate =
                                DateTime.parse(parseDate.toString());
                            var outputFormat =
                                DateFormat(AppContants.DATE_FORMAT);
                            outputDate = outputFormat.format(inputDate);
                          }
                          return SmallText(
                            text: outputDate,
                            size: Dimensions.fontSize16,
                          );
                        }

                        return ListView.builder(
                          itemCount:
                              deliveryDetailController.historyWeightList.length,
                          itemBuilder: (context, index) {
                            return deliveryDetailController.isLoaded
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // cân bì
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: SmallText(
                                              text: f.format(int.parse(
                                                  deliveryDetailController
                                                      .historyWeightList[index]
                                                      .tareWeight!)),
                                              size: Dimensions.fontSize16,
                                            ),
                                          ),
                                          // cân cả hàng
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: SmallText(
                                              text: f.format(int.parse(
                                                  deliveryDetailController
                                                          .historyWeightList[
                                                              index]
                                                          .grossWeight ??
                                                      "0")),
                                              size: Dimensions.fontSize16,
                                            ),
                                          ),
                                          // thời gian cân
                                          Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.width10),
                                            child: timeWidget(index),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Dimensions.screenWidth -
                                                Dimensions.width20 * 2,
                                            height: 1.2,
                                            margin: EdgeInsets.only(
                                                top: 0,
                                                left: Dimensions.width10,
                                                right: Dimensions.width10),
                                            color: AppColor.lineColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : const CustomLoader();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
