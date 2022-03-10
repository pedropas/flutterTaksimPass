import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CapturaImagem extends StatefulWidget {
  const CapturaImagem({Key? key}) : super(key: key);

  @override
  _CapturaImagemState createState() => _CapturaImagemState();
}

class _CapturaImagemState extends State<CapturaImagem> {
  final ImagePicker _picker = ImagePicker();
  XFile? imagem;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("passou aqui");
    _picker.pickImage(source: ImageSource.camera).then((value) {
      if (value != null) {
        imagem = value;
      }
      else
        return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: (){

        },
      ),
    );
  }
}
