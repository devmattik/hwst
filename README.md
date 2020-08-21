# hwst

## Общие требования:
Язык - Swift.
Минимальная поддерживаемая версия ОС - iOS 10.
Использовать Codable для парсинга моделей.
Можно использовать любые сторонние библиотеки.
Дизайн на усмотрение исполнителя.

## Необходимо написать приложение, отображающее сроки отключения горячей воды.

Для того, чтобы получить данные, необходимо использовать следующий метод API:
https://api.gu.spb.ru/UniversalMobileService/classifiers/downloadClassifiers?classifiersId=4

Ответ на запрос имеет следующий вид: 
{
  "status": "result",
  "responseData": {
    "classifiers": [
      {
        "classifierId": 4,
        "classifierName": "График остановок ТЭЦ ТГК-1 2016г",
        "file": "UEsDBBQAAAAIAKWp2VAl0/j9MfcAAAwWOwAYAAA...",
        "version": "26"
      }
    ]
  },
  "expectedResponseDate": "12.08.2020"
}

Значение поля file представляет собой base64 encoded zip-архив. 
Необходимо его декодировать и разархивировать. 
Можно использовать сторонние библиотеки (например, https://github.com/marmelroy/Zip).
Содержимое архива - массив объектов следующего вида:

[
  {
    "Населенный пункт": "Санкт-Петербург",
    "Адрес жилого здания": "Краснопутиловская",
    "№ дома": "65",
    "корпус": "",
    "литер": "",
    "Период отключения ГВС": "22.06.2020-05.07.2020"
  },
  {
    "Населенный пункт": "Санкт-Петербург",
    "Адрес жилого здания": "Ветеранов",
    "№ дома": "47",
    "корпус": "",
    "литер": "",
    "Период отключения ГВС": "22.06.2020-05.07.2020"
  }
]

## Для отображения данных необходимо реализовать экран на UITableView.

Пример содержимого ячейки:
Краснопутиловская
дом 15 корпус 1 литер А
20 мая 2019 - 2 июля 2019

Дата должна быть отформатирована как в примере.
Если у дома отсутствует корпус и/или литер, надписи “корпус”/“литер” не должны отображаться.

## Сделать две заглушки для случаев:
- нет интернета,
- произошла какая-то непредвиденная ошибка (например, в поле file пришло некорректное содержимое и не удалось его раскодировать или разархивировать).
Каждая из заглушек должна содержать кнопку "Попробовать еще", по нажатию на которую приложение попытается еще раз загрузить данные.

Кэшировать получаемые с сервера данные в CoreData и отображать их при последующих запусках, если не удастся получить данные с сервера (например, нет соединения с интернетом).
