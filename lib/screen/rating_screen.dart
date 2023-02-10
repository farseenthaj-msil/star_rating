
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../list/item_list.dart';
import 'package:simple_animations/simple_animations.dart';


class RatingScreen extends StatelessWidget {

  final TextEditingController _controller = TextEditingController();

  RatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Star Rating'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 8, right: 8),
              child: TextField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),],
                onChanged: (value) => double.parse(value),
                decoration: const InputDecoration(
                  labelText: 'Input Your Rating', 
                ),
                textAlign: TextAlign.left,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                
                if (double.tryParse(_controller.text) != null && double.parse(_controller.text) <= 5) {
                  
                  Provider.of<ItemList>(context, listen: false).addItem(double.parse(_controller.text));
                    
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => 
                      Consumer<ItemList>(builder: (context, item, child) {
                          return PlayAnimationBuilder<double>(
                          duration: const Duration(seconds: 4),
                          tween: Tween(begin: 0, end: 1),
                          builder: (context, opacity, child) {
                            return Opacity(
                              opacity: opacity,
                              child: AlertDialog(
                            content: 
                              SizedBox(
                                height: 70,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('Your rating is : ${double.parse(item.items.last)}'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(5, (index) {
                                        
                                        return IconButton(
                                          icon: Provider.of<ItemList>(context, listen: false).getCount() > index + 1 || 
                                                  (double.parse(item.items.last)) == index + 1 ? 
                                                    const Icon(Icons.star) : 
                                                      Provider.of<ItemList>(context, listen: false).getCount() == index + 1 ?
                                                        const Icon(Icons.star_half_outlined) : const Icon( Icons.star_border_outlined),
                                          color: Colors.green,
                                          onPressed: () {},
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                                  
                            )
                            );});


                      })
                    );
                    _controller.clear();
                  } 
              }, 
              child: const Text('Submit'),
            ),  
            Expanded(
              child: 
                Provider.of<ItemList>(context, listen: true).items.isEmpty ? 
                  const Center(child: Text('you have not given any rating')) :

                  Consumer<ItemList>(builder: (context, item, child) {
                  return ListView.builder(
                    itemCount: item.items.length,
                    itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Your rating for item $index is ${item.items[index]}'),
                          );
                    },
                  );
                  }
                      ),
                    
            ),
            
          ],
          
        ),
      ),
    );

  }
}
