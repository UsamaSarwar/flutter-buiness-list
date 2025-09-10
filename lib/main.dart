import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'business_card.dart';
import 'business_provider.dart';

void main() {
	runApp(const BusinessListApp());
}

class BusinessListApp extends StatelessWidget {
	const BusinessListApp({super.key});

	@override
	Widget build(BuildContext context) {
			return MultiProvider(
				providers: [
					ChangeNotifierProvider(create: (_) => BusinessProvider()..fetchBusinesses()),
				],
				child: MaterialApp(
					title: 'Business List',
					theme: ThemeData(
						primarySwatch: Colors.blue,
					),
					initialRoute: '/',
					routes: {
						'/': (context) => const BusinessListScreen(),
						'/details': (context) => const BusinessDetailsScreen(),
					},
				),
			);
	}
}

class BusinessListScreen extends StatelessWidget {
	const BusinessListScreen({super.key});

		@override
		Widget build(BuildContext context) {
			return Scaffold(
				appBar: AppBar(title: const Text('Businesses')),
				body: Consumer<BusinessProvider>(
					builder: (context, provider, _) {
						if (provider.loading) {
							return const Center(child: CircularProgressIndicator());
						}
						if (provider.error != null) {
							return Center(
								child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: [
										Text(provider.error!, style: const TextStyle(color: Colors.red)),
										const SizedBox(height: 8),
										ElevatedButton(
											onPressed: provider.fetchBusinesses,
											child: const Text('Retry'),
										),
									],
								),
							);
						}
						if (provider.businesses.isEmpty) {
							return const Center(child: Text('No businesses found.'));
						}
						return ListView.builder(
							itemCount: provider.businesses.length,
							itemBuilder: (context, index) {
								final biz = provider.businesses[index];
								return BusinessCard(
									name: biz.name,
									location: biz.location,
									contactNo: biz.contactNo,
									onTap: () {
										Navigator.pushNamed(context, '/details', arguments: biz);
									},
								);
							},
						);
					},
				),
			);
		}
}

class BusinessDetailsScreen extends StatelessWidget {
	const BusinessDetailsScreen({super.key});

		@override
		Widget build(BuildContext context) {
				final biz = ModalRoute.of(context)?.settings.arguments;
				if (biz is! Business) {
					return Scaffold(
						appBar: AppBar(title: const Text('Business Details')),
						body: const Center(child: Text('No business selected.')),
					);
				}
				return Scaffold(
					appBar: AppBar(title: const Text('Business Details')),
					body: Padding(
						padding: const EdgeInsets.all(24.0),
						child: Column(
							crossAxisAlignment: CrossAxisAlignment.start,
							children: [
								Text(biz.name, style: Theme.of(context).textTheme.headlineSmall),
								const SizedBox(height: 8),
								Text('Location: ${biz.location}'),
								const SizedBox(height: 8),
								Text('Contact: ${biz.contactNo}'),
							],
						),
					),
				);
		}
}
