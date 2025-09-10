import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
			body: const Center(child: Text('Business list will appear here.')),
		);
	}
}

class BusinessDetailsScreen extends StatelessWidget {
	const BusinessDetailsScreen({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Business Details')),
			body: const Center(child: Text('Business details will appear here.')),
		);
	}
}
