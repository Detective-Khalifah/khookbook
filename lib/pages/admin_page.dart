/// AdminPage provides a comprehensive dashboard interface for administrators to manage
/// halal verifications and reports. It features a tabbed interface that separates
/// pending reports from existing verifications, and integrates with Firebase
/// Firestore for real-time updates.
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:khookbook/providers/halal_verification_provider.dart";
import "package:khookbook/providers/admin_provider.dart";
import "package:khookbook/widgets/status_banner.dart";

/// The main admin dashboard page with real-time data synchronization
class AdminPage extends ConsumerWidget {
  /// Route identifier for navigation
  static const String id = "admin";

  const AdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final verificationProvider = ref.watch(halalVerificationProvider);
    final isAdmin = ref.watch(adminProvider);

    return isAdmin.when(
      data: (isAdmin) {
        if (!isAdmin) {
          return Scaffold(
            body: Center(
              child: Text(
                "Unauthorized: Admin access required",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          );
        }

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Admin Dashboard"),
              bottom: TabBar(
                tabs: const [
                  Tab(text: "Pending Reports"),
                  Tab(text: "Verifications"),
                ],
                labelColor: theme.colorScheme.onSurface,
                indicatorColor: theme.colorScheme.primary,
              ),
            ),
            body: TabBarView(
              children: [
                _PendingReportsTab(verificationProvider: verificationProvider),
                _VerificationsTab(verificationProvider: verificationProvider),
              ],
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (_, __) => Scaffold(
        body: Center(
          child: Text(
            "Error checking admin permissions",
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}

/// Tab for reviewing and managing pending halal verification reports
/// Displays reports submitted by users about recipe halal status that need admin review.
class _PendingReportsTab extends StatelessWidget {
  final HalalVerificationNotifier verificationProvider;

  const _PendingReportsTab({required this.verificationProvider});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("halal_reports")
          .where("status", isEqualTo: "pending")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading reports"));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No pending reports"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final report = snapshot.data!.docs[index];
            final data = report.data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text("Report for Recipe ${data["recipeId"]}"),
                subtitle: Text(data["notes"] ?? "No additional notes"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () => _approveReport(context, report.id, data),
                      tooltip: "Approve",
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _rejectReport(context, report.id),
                      tooltip: "Reject",
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Approves a halal verification report and updates its status in Firestore.
  /// @param context BuildContext for showing feedback
  /// @param reportId The Firestore document ID of the report
  /// @param reportData The report data containing recipeId and other details
  Future<void> _approveReport(
    BuildContext context,
    String reportId,
    Map<String, dynamic> reportData,
  ) async {
    await FirebaseFirestore.instance
        .collection("halal_reports")
        .doc(reportId)
        .update({"status": "approved"});

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Report approved")));
    }
  }

  /// Rejects a halal verification report and updates its status in Firestore.
  /// @param context BuildContext for showing feedback
  /// @param reportId The Firestore document ID of the report
  Future<void> _rejectReport(BuildContext context, String reportId) async {
    await FirebaseFirestore.instance
        .collection("halal_reports")
        .doc(reportId)
        .update({"status": "rejected"});

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Report rejected")));
    }
  }
}

/// Tab for viewing and editing existing halal verifications
/// Displays a list of all verified recipes with their current halal status,
/// allowing admins to review and update verifications as needed.
class _VerificationsTab extends StatelessWidget {
  final HalalVerificationNotifier verificationProvider;

  const _VerificationsTab({required this.verificationProvider});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("halal_verifications")
          .orderBy("verifiedAt", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error loading verifications"));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No verifications yet"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final verification = snapshot.data!.docs[index];
            final data = verification.data() as Map<String, dynamic>;

            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(
                  data["isHalal"] ? Icons.check_circle : Icons.error,
                  color: data["isHalal"] ? Colors.green : Colors.red,
                ),
                title: Text("Recipe ${verification.id}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Verified by: ${data["verifiedBy"]}"),
                    if (data["notes"] != null) Text("Notes: ${data["notes"]}"),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () =>
                      _showEditDialog(context, verification.id, data),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Shows a dialog to edit an existing verification's status and notes.
  /// @param context BuildContext for showing the dialog
  /// @param verificationId The Firestore document ID of the verification
  /// @param data The current verification data to pre-populate the form
  void _showEditDialog(
    BuildContext context,
    String verificationId,
    Map<String, dynamic> data,
  ) {
    final noteController = TextEditingController(text: data["notes"]);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Verification"),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text("Is Halal"),
                value: data["isHalal"],
                onChanged: (value) {
                  data["isHalal"] = value;
                },
              ),
              TextFormField(
                controller: noteController,
                decoration: const InputDecoration(labelText: "Notes"),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await FirebaseFirestore.instance
                    .collection("halal_verifications")
                    .doc(verificationId)
                    .update({
                      "isHalal": data["isHalal"],
                      "notes": noteController.text,
                      "updatedAt": FieldValue.serverTimestamp(),
                    });
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Verification updated")),
                  );
                }
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
