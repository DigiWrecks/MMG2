class Element2Data{
  String image1 = '';
  String image2 = '';
  String image3 = '';
  String image4 = '';
  String image5 = '';

  setImage({imageVar,value}){
    if(imageVar == 'I1'){
      image1 = value;
    }
    else if(imageVar == 'I2'){
      image2 = value;
    }
    else if(imageVar == 'I3'){
      image3 = value;
    }
    else if(imageVar == 'I4'){
      image4 = value;
    }
    else if(imageVar == 'I5'){
      image5 = value;
    }
  }

}