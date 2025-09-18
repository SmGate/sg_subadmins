// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:societyadminapp/Module/support_ticket/controller/supports_ticket_controller.dart';
import 'package:societyadminapp/Module/support_ticket/model/all_ticker_model.dart';
import 'package:societyadminapp/Routes/set_routes.dart';
import 'package:societyadminapp/Widgets/my_back_button.dart';
import 'package:societyadminapp/utils/helpers/date_helpers.dart';
import 'package:societyadminapp/utils/style/colors/app_colors.dart';
import 'package:societyadminapp/utils/style/text_style.dart';

class AllSupportsTickets extends StatelessWidget {
  const AllSupportsTickets({super.key});

  @override
  Widget build(BuildContext context) {
    var supportTicketsController = Get.put(SupportTiccketsController());

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(homescreen, arguments: supportTicketsController.user);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: Column(
            children: [
              MyBackButton(
                text: 'Support Tickets',
                onTap: () {
                  Get.offNamed(homescreen,
                      arguments: supportTicketsController.user);
                },
              ),
              Expanded(
                child: FutureBuilder<GetAllTicketsModel?>(
                  future: supportTicketsController.getAllTicketsMeth(
                      societyId:
                          supportTicketsController.user.societyid.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child:
                            CircularProgressIndicator(color: AppColors.appThem),
                      );
                    }

                    if (snapshot.hasError ||
                        snapshot.data == null ||
                        snapshot.data!.data == null) {
                      return const Center(child: Text("No tickets found"));
                    }

                    final tickets = snapshot.data!.data!;
                    return ListView.builder(
                      itemCount: tickets.length,
                      itemBuilder: (context, index) {
                        final ticket = tickets[index];

                        return Card(
                          surfaceTintColor: AppColors.globalWhite,
                          color: AppColors.globalWhite,
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: CircleAvatar(
                              backgroundColor: AppColors.appThem,
                              child: Text(
                                ticket.id?.toString() ?? "-",
                                style: reusableTextStyle(
                                    color: AppColors.globalWhite),
                              ),
                            ),
                            title: Text(ticket.title ?? "No Title",
                                style: reusableTextStyle(
                                    color: AppColors.textBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(ticket.message ?? "",
                                    style: reusableTextStyle(
                                        color: AppColors.textBlack,
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text("Created: ",
                                        style: reusableTextStyle(
                                            color: AppColors.textBlack,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600)),
                                    Text(
                                        "${DateHelpers().formatDate(ticket.createdAt ?? '')}"),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Text("Status:"),
                                    const SizedBox(width: 10),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: getStatusColor(ticket.status),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        getStatus(ticket.status ?? 'Unknown')
                                            .capitalize!,
                                        style: reusableTextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),

                                    /// 🔽 Change Status Dropdown
                                    PopupMenuButton<String>(
                                      onSelected: (selectedStatus) {
                                        _showConfirmationDialog(
                                            context,
                                            selectedStatus,
                                            ticket.id ?? 0,
                                            supportTicketsController);
                                      },
                                      icon: Text("Change status",
                                          style: reusableTextStyle(
                                            color: Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      itemBuilder: (context) {
                                        return [
                                          'Open',
                                          'In Progress',
                                          'Resolved',
                                          'Closed',
                                        ].map((label) {
                                          return PopupMenuItem<String>(
                                            value: label
                                                .toLowerCase()
                                                .replaceAll(' ', '_'),
                                            child: Text(label),
                                          );
                                        }).toList();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Status Color Mapping
  Color getStatusColor(String? status) {
    switch (status) {
      case 'open':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.redAccent;
    }
  }

  /// ✅ Status Text Mapping
  String getStatus(String? status) {
    switch (status) {
      case 'open':
        return "Open";
      case 'in_progress':
        return "In Progress";
      case 'resolved':
        return "Resolved";
      case 'closed':
        return "Closed";
      default:
        return "Open";
    }
  }

  /// ✅ Confirmation Dialog on Status Change
  void _showConfirmationDialog(
    BuildContext context,
    String selectedStatus,
    int ticketId,
    SupportTiccketsController controller,
  ) {
    final statusText = getStatus(selectedStatus);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        surfaceTintColor: AppColors.globalWhite,
        backgroundColor: AppColors.globalWhite,
        title: const Text("Confirm Status Change"),
        content: Text("Do you want to change status to \"$statusText\"?"),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          Obx(() => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  controller.updateTicket(
                      ticketId: ticketId,
                      status: selectedStatus,
                      context: context);
                },
                child: controller.loading.value
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.globalWhite,
                        ),
                      )
                    : const Text("Yes"),
              )),
        ],
      ),
    );
  }
}
