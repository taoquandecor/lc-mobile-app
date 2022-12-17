import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lcmobileapp/base/custom_loader.dart';
import 'package:lcmobileapp/base/show_custom_snackbar.dart';
import 'package:lcmobileapp/controller/attachment_controller.dart';
import 'package:lcmobileapp/controller/delivery_detail_controller.dart';
import 'package:lcmobileapp/controller/user_controller.dart';
import 'package:lcmobileapp/models/attachment_model.dart';
import 'package:lcmobileapp/models/delivery_detail_body_model.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/models/delivery_detail_work_flow_model.dart';
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
import 'package:lcmobileapp/widgets/display_row_data_widget.dart';
import 'package:lcmobileapp/widgets/edit_box_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:timelines/timelines.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';

class SecondWeightDetailPage extends StatefulWidget {
  int pageId;
  SecondWeightDetailPage({super.key, required this.pageId});

  @override
  State<SecondWeightDetailPage> createState() => _SecondWeightDetailPageState();
}

class _SecondWeightDetailPageState extends State<SecondWeightDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  int _netWeight = 0;
  var weightController = TextEditingController();
  var remarkController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  late TokenTimeOut _tokenTimeOut;

  @override
  void initState() {
    weightController.addListener(() {
      weightController.text;
    });
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
    _netWeight = 0;
  }

  @override
  void dispose() {
    weightController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DeliveryDetailModel _deliveryDetail =
        Get.find<DeliveryDetailController>().pendingTicketList[widget.pageId];

    var f = NumberFormat(AppContants.FORMAT_NUMER);
    var vehiclePrimaryId = _deliveryDetail.vehiclePrimaryId ?? "";
    var vehicleSecondaryId = _deliveryDetail.vehicleSecondaryId ?? "";
    var deliveryDetailId = _deliveryDetail.id ?? "";

    List<DeliveryDetailWorkFlowModel> _delvieryDetailWFList = [];
    Get.find<DeliveryDetailController>().getTimeLines(deliveryDetailId);
    _delvieryDetailWFList =
        Get.find<DeliveryDetailController>().deliveryDetailWFList;

    Get.find<AttachmentController>().getImageTicket(deliveryDetailId);
    AttachmentModel _attachmentModel =
        Get.find<AttachmentController>().attachmentModel;

    String imageUrl = "";
    String imagePath = _attachmentModel.path ?? "";

    Widget showImage() {
      try {
        HttpOverrides.global = MyHttpOverrides();
        if (imagePath.isEmpty) {
          return Image.asset("assets/images/no_image_available.png");
        }
        imageUrl = AppContants.BASE_URL + AppContants.SLASH + imagePath;
        return Image.network(imageUrl, headers: AppContants.HEADER_IMAGE);
      } catch (e) {
        return Image.asset("assets/images/no_image_available.png");
      }
    }

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
            tareWeight: int.parse(number),
            workflowCode: AppContants.TARE_WF,
          );
        } else if (cargoDirection == AppContants.UNLOADING ||
            cargoDirection == AppContants.STORAGE_EXPORT) {
          // dỡ hàng hoặc xuất kho thì cân chốt là gross
          deliveryDetailBody = DeliveryDetailBody(
            grossWeight: int.parse(number),
            remark: remark,
            tareScaleId: "",
            grossScaleId: "",
            tareWeight: 0,
            workflowCode: AppContants.GROSS_WF,
          );
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
              Get.snackbar("Token", AppMessage.ERROR_MESSAGE5);
            } else {
              Get.snackbar(AppMessage.WEIGHT_OUT, status.message);
            }
          }
        });
      }
    }

    return DefaultTabController(
      length: 4,
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
            size: Dimensions.fontSize20,
          ),
          backgroundColor: AppColor.backgroundWhiteColor,
          elevation: 0,
          bottom: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: [
              Tab(
                icon: AppIcon(
                  icon: Icons.info_outline,
                  iconColor:
                      _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize20,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                iconMargin: EdgeInsets.only(top: Dimensions.height10),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.DETAIL_TAB,
                    size: Dimensions.fontSize12,
                    color:
                        _currentIndex == 0 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.scale_outlined,
                  iconColor:
                      _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize20,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                iconMargin: EdgeInsets.only(top: Dimensions.height10),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.WEIGHT_OUT_TEXT,
                    size: Dimensions.fontSize12,
                    color:
                        _currentIndex == 1 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.list_sharp,
                  iconColor:
                      _currentIndex == 2 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize20,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                iconMargin: EdgeInsets.only(top: Dimensions.height10),
                child: Align(
                  alignment: Alignment.center,
                  child: BigText(
                    text: AppMessage.TIMELINES,
                    size: Dimensions.fontSize12,
                    color:
                        _currentIndex == 2 ? AppColor.mainColor : Colors.grey,
                  ),
                ),
              ),
              Tab(
                icon: AppIcon(
                  icon: Icons.history,
                  iconColor:
                      _currentIndex == 3 ? AppColor.mainColor : Colors.grey,
                  iconSize: Dimensions.fontSize20,
                  backgroundColor: AppColor.backgroundWhiteColor,
                ),
                iconMargin: EdgeInsets.only(top: Dimensions.height10),
                child: Align(
                    alignment: Alignment.center,
                    child: BigText(
                      text: AppMessage.HISTORY_TAB,
                      size: Dimensions.fontSize12,
                      color:
                          _currentIndex == 3 ? AppColor.mainColor : Colors.grey,
                    )),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: Dimensions.height10,
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
                        size: Dimensions.fontSize12,
                      ),
                      DisplayRowDataWidget(
                        firstField: _deliveryDetail.vesselCode ?? "",
                        secondField: _deliveryDetail.bargeCode ?? "",
                        firstColor: AppColor.mainColor,
                        secondColor: Colors.black,
                        firstSize: Dimensions.fontSize12,
                        secondSize: Dimensions.fontSize12,
                      )
                    ],
                  ),
                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      DisplayRowDataWidget(
                        firstField: _deliveryDetail.vehiclePrimaryCode ?? "",
                        secondField: _deliveryDetail.vehicleSecondaryCode ?? "",
                        firstColor: AppColor.mainColor,
                        secondColor: Colors.black,
                        firstSize: Dimensions.fontSize12,
                        secondSize: Dimensions.fontSize12,
                      )
                    ],
                  ),

                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      DisplayRowDataWidget(
                        firstField: _deliveryDetail.manifestConsigneeCode ?? "",
                        secondField: _deliveryDetail.manifestDelegateCode ?? "",
                        firstColor: Colors.black,
                        secondColor: Colors.black,
                        firstSize: Dimensions.fontSize10,
                        secondSize: Dimensions.fontSize10,
                      )
                    ],
                  ),

                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      DisplayRowDataWidget(
                        firstField: _deliveryDetail.consigneeCode ?? "",
                        secondField: _deliveryDetail.delegateCode ?? "",
                        firstColor: Colors.black,
                        secondColor: Colors.black,
                        firstSize: Dimensions.fontSize10,
                        secondSize: Dimensions.fontSize10,
                      )
                    ],
                  ),

                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.cargoName ?? "",
                            size: Dimensions.fontSize10,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.billOfLading ?? "",
                            size: Dimensions.fontSize10,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.serviceTypeName ?? "",
                            size: Dimensions.fontSize10,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  DottedLine(
                    dashColor: AppColor.dotColor,
                  ),
                  SizedBox(
                    height: Dimensions.height10,
                  ),

                  // Hướng hàng
                  CargoDirectWiget(
                      cargoDirectId: _deliveryDetail.cargoDirection ?? ""),

                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: _deliveryDetail.operationTerminalName ?? "",
                            size: Dimensions.fontSize10,
                            color: Colors.black,
                          ),
                        ],
                      )
                    ],
                  ),

                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text:
                                "${f.format(int.parse(_deliveryDetail.remainQuantity ?? "0"))} (Kg)",
                            size: Dimensions.fontSize12,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
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
                            size: Dimensions.fontSize10,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  DottedLine(
                    dashColor: AppColor.dotColor,
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.only(
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
                    ),
                    child: showImage(),
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
                        size: Dimensions.fontSize12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text:
                                "${f.format(int.parse(_deliveryDetail.remainQuantity ?? "0"))} (Kg)",
                            size: Dimensions.fontSize12,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
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
                            size: Dimensions.fontSize12,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  DottedLine(
                    dashColor: AppColor.dotColor,
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
                        size: Dimensions.fontSize12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BigText(
                            text: "${f.format(_netWeight)} (Kg)",
                            size: Dimensions.fontSize12,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      )
                    ],
                  ),
                  DottedLine(
                    dashColor: AppColor.dotColor,
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
            Container(
                color: Colors.white,
                margin: EdgeInsets.only(
                    top: Dimensions.height10,
                    left: Dimensions.width10,
                    right: Dimensions.width10,
                    bottom: Dimensions.height10),
                child: GetBuilder<DeliveryDetailController>(
                  builder: ((deliveryDetailWFController) {
                    Widget timeWidget(int index) {
                      var outputDate = DateTime.now().toString();
                      var createdDate =
                          _delvieryDetailWFList[index].createdDate ?? "";
                      if (index < _delvieryDetailWFList.length) {
                        if (createdDate != "") {
                          DateTime parseDate =
                              DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(
                                  _delvieryDetailWFList[index].createdDate!);
                          var inputDate = DateTime.parse(parseDate.toString());
                          var outputFormat =
                              DateFormat(AppContants.DATE_FORMAT2);
                          outputDate = outputFormat.format(inputDate);
                        } else {
                          outputDate = "";
                        }
                      }
                      return BigText(
                        text: outputDate,
                        size: Dimensions.fontSize12,
                      );
                    }

                    Widget showContent(int index) {
                      String content =
                          "${_delvieryDetailWFList[index].wFCode} - ${_delvieryDetailWFList[index].wFName}";
                      String createdBy =
                          _delvieryDetailWFList[index].createdBy ?? "";
                      String remark = _delvieryDetailWFList[index].remark ?? "";
                      if (createdBy != "" && remark != "") {
                        content +=
                            "- ${AppMessage.FOR} $createdBy ${AppMessage.REMARK}: $remark";
                      } else if (createdBy != "" && remark == "") {
                        content += "- ${AppMessage.FOR} $createdBy";
                      } else {}
                      return Text(
                        content,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 20,
                        style: TextStyle(fontSize: Dimensions.fontSize12),
                      );
                    }

                    Color nodeTimeLine(int index) {
                      var createdDate =
                          _delvieryDetailWFList[index].createdDate ?? "";
                      if (createdDate == "") {
                        return Colors.grey;
                      }
                      return AppColor.mainColor;
                    }

                    return Timeline.builder(
                        itemCount: _delvieryDetailWFList.length,
                        itemBuilder: ((context, index) {
                          return TimelineTile(
                            oppositeContents: Container(
                              height: Dimensions.height50 * 2,
                              padding: EdgeInsets.only(
                                top: 0,
                                left: Dimensions.width10 / 2,
                                right: Dimensions.width20,
                              ),
                              child: timeWidget(index),
                            ),
                            contents: Container(
                              margin: EdgeInsets.only(
                                top: 0,
                                bottom: Dimensions.height10,
                                left: Dimensions.width10 / 2,
                                right: Dimensions.width20,
                              ),
                              height: Dimensions.height50 * 2,
                              child: showContent(index),
                            ),
                            node: TimelineNode(
                              indicator: DotIndicator(
                                position: 0,
                                color: nodeTimeLine(index),
                              ),
                              startConnector: SolidLineConnector(
                                color: AppColor.lineColor,
                              ),
                              endConnector: SolidLineConnector(
                                color: AppColor.lineColor,
                              ),
                            ),
                          );
                        }));
                  }),
                )),
            Container(
              color: AppColor.backgroundWhiteColor,
              margin: EdgeInsets.only(
                  top: Dimensions.height10,
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
                              size: Dimensions.fontSize12,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.GROSS_WEIGHT,
                              size: Dimensions.fontSize12,
                            )),
                        Container(
                            margin: EdgeInsets.all(Dimensions.width10),
                            child: BigText(
                              text: AppMessage.WEIGHT_TIME,
                              size: Dimensions.fontSize12,
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
                            size: Dimensions.fontSize12,
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
                                              size: Dimensions.fontSize12,
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
                                              size: Dimensions.fontSize12,
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
                                      DottedLine(
                                        dashColor: AppColor.dotColor,
                                      ),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
