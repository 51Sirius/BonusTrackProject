# BonusTrackProject
## Содержание

* [Описание предметной области](#po)
* [Er диаграмма](#diagram)
* [Скрипты](#scripts)
  * [Скрипт создания таблиц](#scripts-1)
  * [Скрипт заполнения таблиц](#scripts-2)
  * [Скрипты запросов](#scripts-3)
* [Описание таблиц, столбцов](#desc-table)
  * [Product](#desc-table-1)
  * [User](#desc-table-2)
  * [PaymentDetails](#desc-table-3)
  * [Basket](#desc-table-4)
  * [Comment](#desc-table-5)
  * [SearchHistory](#desc-table-6)
  * [Favorites](#desc-table-7)
  * [PickupPoint](#desc-table-8)
  * [Storehouse](#desc-table-9)
  * [Distance](#desc-table-10)
  * [Market](#desc-table-11)
  * [Properties](#desc-table-12)
  * [PropertiesType](#desc-table-13)
  * [ProductCategory](#desc-table-14)
  * [ProductSubCategory](#desc-table-15)

<a name="po"></a>
### Описание предметной области

Проект реализуется на СУБД - PostgreSQL.

Сайт интернет-товаров позволяет пользователям искать товары у разных продавцов онлайн и заказывать их. При поиске пользователь может задать название товара, категорию товаров и так далее. Есть также фильтры, и сортировка. Фильтры зависят от категории товаров т.к. имеют свою специфику. Выбрав необходимые фильтры, пользователь может искать товары по ним. Совокупность фильтров, сортировок и рекомендаций пользователя представляют собой поисковой запрос, который делается на сайте путем сообщения минимально необходимой информации о покупателе и товарах. Информация о покупателе храниться в базе данных магазина, бизнес-модель магазина рассчитана на повторный поиск, поэтому сохраняет историю поиска, для подбора индивидуальных акций и рекомендаций поискав будущем. Так же пользователь может добавлять товары в избранное, корзину, оставлять отзывы и оценку на товар, добавлять способы оплаты.

Моделирование охватывает бизнес-процессы: Поиск товаров на онлайн-маркете, просмотр их на сайте, добавление в корзину, и возможность отправить данные микросервису для дальнейшей оплаты

<a name="diagram"></a>
### Er диаграмма
![Er диаграмма](https://github.com/51Sirius/BonusTrackProject/blob/main/er-diagram.png?raw=true)
[Ссылка на er диаграмму на сайте drawsql](https://drawsql.app/teams/belaz-team/diagrams/onlinemarket)

<a name="scripts"></a>
### Скрипты

<a name="scripts-1"></a>
#### Скрипт создания таблиц
Скрипт предоставлен в файле [create.sql](https://github.com/51Sirius/BonusTrackProject/blob/main/create.sql)

<a name="scripts-2"></a>
#### Скрипт заполнения таблиц
Скрипт предоставлен в файле [insert.sql](https://github.com/51Sirius/BonusTrackProject/blob/main/insert.sql), скрипт был сгенирирован с помощью написанной мною программы, которую можно [посмотреть](https://github.com/51Sirius/BonusTrackProject/blob/main/script.ipynb), также в ней есть подробный отчет, как она устроена.

<a name="scripts-3"></a>
#### Скрипты запросов
1. запрос: получение товаров из категории спорт, товары отсортированны по рейтингу
```sql
SELECT p."Name", p."Price", p."Rating" FROM "Product" as p
JOIN "ProductSubCategory" as PSC on p."ProductSubCategoryId" = PSC."Id"
JOIN "ProductCategory" as PC on PSC."ProductCategoryId" = PC."Id"
WHERE PC."Name" = 'Спорт'
order by p."Rating" DESC
```
2. запрос: получить историю поиска, для 3 пользователя
```sql
SELECT p."Name", p."Price" FROM "Product" as p
JOIn "SearchHistory" as SH on SH."ProductId" = P."Id"
JOIN "User" as U on U."Id" = SH."UserId"
WHERE U."Id" = 3
order by p."Rating" DESC
```
3. запрос: получить список товаров, которые можно быстро доставить для первого пользователя
```sql
SELECT p."Name", p."Price", p."Rating" FROM "Product" as p
JOIN "Storehouse" AS SH on P."StorehouseId" = SH."Id"
JOIN "Distance" As D on SH."Id" = D."StorehouseId"
JOIN "PickupPoint" as PP on D."PickupPointId"=PP."Id" 
JOIN "User" as U on U."PickupPointId" = PP."Id"
WHERE U."Id"=0 and D."Distance"<1000
order by p."Rating" DESC
```
4. запрос: получение товаров, где высокий рейтинг продавцов
```sql
WITH "TopMarkets" as (SELECT * From "Market" as M
                  WHERE m."Rating" > 5)


SELECT p."Name", p."Price", p."Rating" FROM "Product" as p
JOIN "TopMarkets" AS TP on P."MarketId" = TP."Id"
order by p."Rating" DESC
```
5. запрос: получение товаров у которых средний рейтинг комментариев выше пяти
```sql
WITH "AvgProductCommentsRating" as (SELECT P."Id" as "ProductId",AVG(TC."Rating") as "Rating" FROM "Product" as p
                                    JOIN "Comment" AS TC on TC."ProductId" = P."Id"
                                    GROUP by P."Id")
                                  

SELECT p."Name", p."Price", p."Rating" FROM "Product" as p
JOIN "AvgProductCommentsRating" AS APC on APC."ProductId" = P."Id"
WHERE APC."Rating" > 5
order by p."Rating" DESC
```

<a name="desc-table"></a>
### Описание таблиц, столбцов

<a name="desc-table-1"></a>
#### Таблица Product
Таблица описывает сущность какого бы то ни было товара в онлайн-маркете
* Id - уникальный индефикатор продукта
* Name - название продукта
* Description - описание продукта
* Rating - рейтинг продукта
* ProductSubCategoryId - внешний ключ указывающий на под категорию товара
* MarketId - внешний ключ указывающий на магазин/продавца который выставил товар
* Price - цена товара
* PictureURL - ссылка на картинку товара
* Status - статус товара (ex. закончился, в наличии)
* StorehouseId - ключ указывающий на каком складе лежит товар

<a name="desc-table-2"></a>
#### Таблица User
Таблица описывает сущность пользователя-покупателя
* Id - уникальный индефикатор пользователя
* PickupPointId - пункт выдачи, с которого пользователь выбрал забирать товар
* FirstName - имя пользователя
* LastName - фамилия пользователя
* SurName - отчество пользователя
* Birthday - день рождения пользователя
* Email - почта пользователя
* PhoneNumber - номер телефона пользователя
* Score - количество очков пользователя (ex. в яндекс маркете очки)
* Gender - пол пользователя
* CreateDate - дата создания аккаунта пользователя

<a name="desc-table-3"></a>
#### Таблица PaymentDetails
Данные для платежа пользователя
* Id - уникальный индефикатор способа оплаты
* Type - тип оплаты (ex. по номеру телефона/ по карте)
* CardNumber - номер карты
* CardName - имя написанное на карте
* CardType - тип карты (ex. Visa/MasterCard)
* PhoneNumber - номер телефона
* Verified - подтвержденный ли способ оплаты
* UserId - внешний ключ, который ссылается на пользователя которому принадлежит этот способ оплаты.

<a name="desc-table-4"></a>
#### Таблица Basket
Представляет сущность корзины, куда пользователь складывает товары, которые он хотел бы приобрести
* ProductId - внешний ключ, ссылающийся на товар
* UserId - внешний ключ, ссылающийся на пользователя

<a name="desc-table-5"></a>
#### Таблица Comment
Сущность комментриев пользователей под товарами
* Id - уникальный индефикатор комментария
* CreateDate - дата создания комментария
* Text - текст комментария
* ProductId - внешний ключ, ссылающийся на товар под которым был оставлен комментарий
* UserId - внешний ключ, ссылающийся на пользователя который оставил комментарий

<a name="desc-table-6"></a>
#### Таблица SearchHistory
Представляет сущность истори поиска, где сохраняются товары, которые просматривал пользователь
* ProductId - внешний ключ, ссылающийся на товар
* UserId - внешний ключ, ссылающийся на пользователя

<a name="desc-table-7"></a>
#### Таблица Favorites
Представляет сущность списка избранных товаров, где сохраняются товары, которые понравились пользователю
* ProductId - внешний ключ, ссылающийся на товар
* UserId - внешний ключ, ссылающийся на пользователя

<a name="desc-table-8"></a>
#### Таблица PickupPoint
Представляет из себя сущность пункта выдачи товаров
* Id - уникальный индефикатор пункта выдачи товаров
* Place - адрес нахождения пункта выдачи
* TimeToWork - время закрытия пункта выдачи

<a name="desc-table-9"></a>
#### Таблица StoreHouse
Представляет из себя сущность пункта хранения, откуда будут доставляться товары на пункт выдачи
* Id - уникальный индефикатор пункта хранения
* Place - адрес нахождения пункта хранения

<a name="desc-table-10"></a>
#### Таблица Distance
Представляет из себя связь пунктов выдачи и пунктов хранения, в виде дистанции с помощью которой можно сказать, когда будет товар
* Distance - дистанция между пунктами выдачи и пунктами хранения
* StorehouseId - уникалный индефикатор пункта хранения товаров
* PickupPointId - уникальный индефикатор пункта выдачи

<a name="desc-table-11"></a>
#### Таблица Market
Представляет из себя сущность магазина/продавца товаров
* Id - уникальный индефикатор продавца/магазина
* Name - Название магазина/продавца
* Rating - рейтинг магазина/продавца

<a name="desc-table-12"></a>
#### Таблица Properties
Представляет из себя сущность свойства товара(ex. цвет, вес)
* Id - уникальный индефикатор свойства
* Name - имя свойства
* ProductSubCategoryId - внешний ключ, который ссылается на подкатегорию товаров соответствующих этому свойству

<a name="desc-table-13"></a>
#### Таблмца PropertiesType
Представляет из себя сущность типов свойств товара (ex. Зеленый, тяжелый)
* Name - название типа свойства
* PropertiesId - внешний ключ, который ссылается на свойство

<a name="desc-table-14"></a>
#### Таблица ProductCategory
Представляет из себя сущность категории товаров
* Id - уникальный индефикатор категории товаров
* Name - название категории товаров

<a name="desc-table-15"></a>
#### Таблица ProductSubCategory
Представляет из себя сущность под категории товаров
* Id - уникальный индефикатор под категории товара
* Name - название под категории
* ProductCategoryId - внешний ключ, ссылающийся на категорию товаров к которой принадлежит эта подкатегория 
