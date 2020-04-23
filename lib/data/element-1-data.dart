class Element1Data {

   String image1 = '';
   String image2 = '';
   String image3 = '';
   String image4 = '';
   String image5 = '';

   String select1 = 'image';
   String select2 = 'image';
   String select3 = 'image';
   String select4 = 'image';
   String select5 = 'image';




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

   setSelected({select,value}){
     if(select == 'S1'){
       select1 = value;
     }
     else if(select == 'S2'){
       select2 = value;
     }
     else if(select == 'S3'){
       select3 = value;
     }
     else if(select == 'S4'){
       select4 = value;
     }
     else if(select == 'S5'){
       select5 = value;
     }
   }

}