import 'package:flutter/material.dart';

class GenericCard<T> extends StatelessWidget {
  final T item;
  final Widget Function(T) builder;
  final VoidCallback? onTap;

  const GenericCard({
    super.key,
    required this.item,
    required this.builder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: builder(item),
        ),
      ),
    );
  }
}

class BusinessCard extends StatelessWidget {
  final String name;
  final String location;
  final String contactNo;
  final VoidCallback? onTap;

  const BusinessCard({
    super.key,
    required this.name,
    required this.location,
    required this.contactNo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GenericCard<BusinessCard>(
      item: this,
      onTap: onTap,
      builder: (item) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(item.location, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 4),
          Text(item.contactNo, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
