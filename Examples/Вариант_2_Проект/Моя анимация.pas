﻿##
uses Анимации;
  ЗаголовокОкна('Моя анимашка');
  ФоноваяКартинка('Фон.png');  
  СоздатьКлип('Г1','Горы1.png');
  Клип('Г1').НачальноеПоложение(0,140);
  СоздатьКлип('Г2','Горы2.png');
  Клип('Г2').НачальноеПоложение(0,340);
  СоздатьКлип('Д','Дорога.png');
  Клип('Д').НачальноеПоложение(0,485);
  СоздатьКлип('О','Облака.png');
  Клип('О').НачальноеПоложение(0,0);
  Клип('О').РазмножитьВправоНа(2).СмещатьВлевоНа(5);
  Клип('Г1').РазмножитьВправоНа(2).СмещатьВлевоНа(10);
  Клип('Г2').РазмножитьВправоНа(2).СмещатьВлевоНа(20);
  Клип('Д').РазмножитьВправоНа(2).СмещатьВлевоНа(30);
  СоздатьКлип('К','Кот.png');
  Клип('К').РазмерКадра(250,120).НачальноеПоложение(250,390).Скорость(8);
  ЗапуститьАнимацию(); 