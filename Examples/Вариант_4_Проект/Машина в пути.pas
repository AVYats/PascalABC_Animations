﻿##
uses Анимации;
  РазмерОкна(900,550);
  ЗаголовокОкна('Моя анимашка');
  ФоноваяКартинка('картинки/Фон.png');  
  СоздатьКлип('Природа','картинки/Природа.png').НачальноеПоложение(0,215).РазмножитьВправоНа(3).СмещатьВлевоНа(5).МаксГоризонтСмещение(450);
  СоздатьКлип('Дорога','картинки/Дорога.png').НачальноеПоложение(0,425).РазмножитьВправоНа(7).СмещатьВлевоНа(10).МаксГоризонтСмещение(150);
  СоздатьКлип('Машина','картинки/Машина.png').НачальноеПоложение(325,325).РазмерКадра(250,165).Скорость(8);
  СоздатьКлип('ПтицаЛ','картинки/ПтицаВлево.png').НачальноеПоложение(1200,100).РазмерКадра(112,148).Скорость(10).СмещатьВлевоНа(25).МаксГоризонтСмещение(1500).СмещатьВверхНа(3).МаксВертикСмещение(150);
  СоздатьКлип('ПтицаР','картинки/ПтицаВправо.png').НачальноеПоложение(-100,200).РазмерКадра(112,148).Скорость(10).СмещатьВправоНа(35).МаксГоризонтСмещение(1500).СмещатьВверхНа(10).МаксВертикСмещение(350);
  ЗапуститьАнимацию();