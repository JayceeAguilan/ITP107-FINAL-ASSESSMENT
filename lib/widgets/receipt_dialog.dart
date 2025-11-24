import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';

class ReceiptDialog extends StatelessWidget {
  final CartProvider cart;
  final String paymentMethod;
  final VoidCallback onContinue;

  const ReceiptDialog({
    super.key,
    required this.cart,
    required this.paymentMethod,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              painter: ReceiptPainter(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Payment Successful',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateFormat('MMM dd, yyyy  hh:mm a').format(DateTime.now()),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(thickness: 1, height: 1, color: Colors.grey),
                    const SizedBox(height: 24),

                    // Items
                    ...cart.items.values.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      '${item.selectedSize} / ${item.selectedColor} x ${item.quantity}',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\u20B1${item.totalPrice.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        )),

                    const SizedBox(height: 12),
                    CustomPaint(
                      painter: DashedLinePainter(),
                      size: const Size(double.infinity, 1),
                    ),
                    const SizedBox(height: 16),

                    // Totals
                    _buildSummaryRow('Subtotal', cart.subtotal),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Tax', cart.taxAmount),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Shipping', 0), // Assuming free shipping
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'TOTAL',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '\u20B1${cart.totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),
                    
                    // Payment Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _getPaymentIcon(paymentMethod),
                            color: Colors.grey[700],
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Paid with ${_formatPaymentMethod(paymentMethod)}',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                    
                    // Barcode (Visual only)
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          30,
                          (index) => Container(
                            width: index % 3 == 0 ? 2 : 4,
                            height: 40,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ORDER #${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 2,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          amount == 0 ? 'Free' : '\u20B1${amount.toStringAsFixed(2)}',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  IconData _getPaymentIcon(String method) {
    switch (method) {
      case 'credit_card':
        return Icons.credit_card;
      case 'paypal':
        return Icons.payment; // Or a custom icon
      case 'gcash':
        return Icons.account_balance_wallet;
      default:
        return Icons.money;
    }
  }

  String _formatPaymentMethod(String method) {
    switch (method) {
      case 'credit_card':
        return 'Credit Card';
      case 'paypal':
        return 'PayPal';
      case 'gcash':
        return 'GCash';
      default:
        return method;
    }
  }
}

class ReceiptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 10);

    // Jagged bottom edge
    const toothWidth = 10.0;
    const toothHeight = 10.0;
    final teethCount = (size.width / toothWidth).ceil();

    for (var i = 0; i < teethCount; i++) {
      final x = size.width - (i * toothWidth);
      path.lineTo(x - (toothWidth / 2), size.height);
      path.lineTo(x - toothWidth, size.height - toothHeight);
    }

    path.lineTo(0, size.height - toothHeight);
    path.close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.1), 4.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;

    var max = size.width;
    var dashWidth = 5;
    var dashSpace = 5;
    double startX = 0;

    while (startX < max) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
