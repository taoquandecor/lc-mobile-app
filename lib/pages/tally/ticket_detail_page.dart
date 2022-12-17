import 'package:flutter/material.dart';
import 'package:lcmobileapp/controller/dashboard_controller.dart';
import 'package:lcmobileapp/models/delivery_detail_model.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_constants.dart';
import 'package:lcmobileapp/utils/app_message.dart';
import 'package:lcmobileapp/utils/dimensions.dart';
import 'package:lcmobileapp/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:lcmobileapp/widgets/cargo_direct_widget.dart';
import 'package:lcmobileapp/widgets/display_row_data_widget.dart';
import 'package:lcmobileapp/widgets/small_text.dart';
import 'package:intl/intl.dart';

class TicketDetailPage extends StatefulWidget {
  int pageId;
  TicketDetailPage({super.key, required this.pageId});

  @override
  State<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends State<TicketDetailPage> {
  var f = NumberFormat(AppContants.FORMAT_NUMER);

  String formatDateTime(String weightTime) {
    var outputDate = DateTime.now().toString();

    DateTime parseDate =
        DateFormat(AppContants.SQL_DATETIME_FORMAT).parse(weightTime);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat(AppContants.DATE_FORMAT2);
    outputDate = outputFormat.format(inputDate);

    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final DeliveryDetailModel _deliveryDetail =
        Get.find<DashboardController>().deliveryDetailList[widget.pageId];
    return Scaffold(
      backgroundColor: AppColor.backgroundWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundWhiteColor,
        centerTitle: true,
        title: BigText(
          text: AppMessage.DELIVERY_DETAIL,
          size: Dimensions.fontSize14,
          color: AppColor.mainColor,
        ),
        leading: BackButton(
          color: AppColor.mainColor,
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Container(
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
                      ? AppMessage.GROSS_WEIGHT
                      : AppMessage.TARE_WEIGHT,
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
                          ? "${f.format(int.parse(_deliveryDetail.grossWeight ?? "0"))} (Kg) ${AppMessage.AT} ${formatDateTime(_deliveryDetail.grossTime.toString())}"
                          : "${f.format(int.parse(_deliveryDetail.tareWeight ?? "0"))} (Kg) ${AppMessage.AT} ${formatDateTime(_deliveryDetail.tareTime.toString())}",
                      size: Dimensions.fontSize10,
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
                      text:
                          "${f.format(int.parse(_deliveryDetail.grossWeight ?? "0") - int.parse(_deliveryDetail.tareWeight ?? "0"))} (Kg) ${AppMessage.AT} ${formatDateTime(_deliveryDetail.grossTime.toString())}",
                      size: Dimensions.fontSize10,
                      color: Colors.black,
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
    );
  }
}
