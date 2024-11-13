import 'package:flutter/material.dart';
 
void main() {
  runApp(CurrencyConverterApp());
}
 
class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: LoginScreen(),
    );
  }
}
 
// Login Screen
class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to Conversion Type Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConversionTypeScreen()),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
 
// Conversion Type Selection Screen
class ConversionTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Select Conversion Type'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Fiat Conversion Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FiatConversionScreen()),
                );
              },
              child: Text('Fiat Conversion'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Cryptocurrency Conversion Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CryptocurrencyConversionScreen()),
                );
              },
              child: Text('Cryptocurrency Conversion'),
            ),
          ],
        ),
      ),
    );
  }
}
 
// Fiat Conversion Screen
class FiatConversionScreen extends StatefulWidget {
  @override
  _FiatConversionScreenState createState() => _FiatConversionScreenState();
}
 
class _FiatConversionScreenState extends State<FiatConversionScreen> {
  String _fromCurrency = 'SGD';
  String _toCurrency = 'USD';
  double _amount = 1000.0;
  double _convertedAmount = 736.70;
  double _exchangeRate = 0.7367;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Currency Converter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Check live rates, set rate alerts, receive notifications and more.',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            CurrencyCard(
              currency: _fromCurrency,
              amount: _amount,
              onCurrencyChanged: (value) => setState(() => _fromCurrency = value),
              onAmountChanged: (value) =>
                  setState(() => _amount = double.parse(value)),
            ),
            SizedBox(height: 8),
            IconButton(
              icon: Icon(Icons.swap_vert, color: Colors.blueAccent),
              onPressed: () {
                setState(() {
                  // Swap the currencies and recalculate
                  String temp = _fromCurrency;
                  _fromCurrency = _toCurrency;
                  _toCurrency = temp;
                  _convertedAmount = _amount * _exchangeRate;
                });
              },
            ),
            CurrencyCard(
              currency: _toCurrency,
              amount: _convertedAmount,
              isReadOnly: true,
              onCurrencyChanged: (value) => setState(() => _toCurrency = value),
              onAmountChanged: (_) {}, // Dummy function for read-only card
            ),
            SizedBox(height: 16),
            Text(
              'Indicative Exchange Rate',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            SizedBox(height: 4),
            Text(
              '1 $_fromCurrency = ${_exchangeRate.toStringAsFixed(4)} $_toCurrency',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 
// Cryptocurrency Conversion Screen (placeholder)
class CryptocurrencyConversionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Cryptocurrency Converter'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          'Cryptocurrency conversion feature coming soon!',
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ),
    );
  }
}
 
// CurrencyCard widget
class CurrencyCard extends StatelessWidget {
  final String currency;
  final double amount;
  final bool isReadOnly;
  final Function(String) onCurrencyChanged;
  final Function(String) onAmountChanged;
 
  CurrencyCard({
    required this.currency,
    required this.amount,
    this.isReadOnly = false,
    required this.onCurrencyChanged,
    required this.onAmountChanged,
  });
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          DropdownButton<String>(
            value: currency,
            items: <String>['SGD', 'USD', 'EUR', 'JPY']
                .map((String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
                .toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onCurrencyChanged(newValue);
              }
            },
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              initialValue: amount.toStringAsFixed(2),
              readOnly: isReadOnly,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (!isReadOnly && value.isNotEmpty) {
                  onAmountChanged(value);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}