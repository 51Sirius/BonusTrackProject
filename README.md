# BonusTrackProject
## Содержание
[Описание предметной области](### Описание предметной области)
### Описание предметной области
Сайт интернет-товаров позволяет пользователям искать товары у разных продавцов онлайн и заказывать их. При поиске пользователь может задать название товара, категорию товаров и так далее. Есть также фильтры, и сортировка. Фильтры зависят от категории товаров т.к. имеют свою специфику. Выбрав необходимые фильтры, пользователь может искать товары по ним. Совокупность фильтров, сортировок и рекомендаций пользователя представляют собой поисковой запрос, который делается на сайте путем сообщения минимально необходимой информации о покупателе и товарах. Информация о покупателе храниться в базе данных магазина, бизнес-модель магазина рассчитана на повторный поиск, поэтому сохраняет историю поиска, для подбора индивидуальных акций и рекомендаций поискав будущем. Так же пользователь может добавлять товары в избранное, корзину, оставлять отзывы и оценку на товар, добавлять способы оплаты.

Моделирование охватывает бизнес-процессы: Поиск товаров на онлайн-маркете, просмотр их на сайте, добавление в корзину, и возможность отправить данные микросервису для дальнейшей оплаты

### Er диаграмма
![Er диаграмма](https://github.com/51Sirius/BonusTrackProject/blob/main/er-diagram.png?raw=true)
[Ссылка на er диаграмму на сайте drawsql](https://drawsql.app/teams/belaz-team/diagrams/onlinemarket)

### Описание таблиц, столбцов

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

#### Таблица Basket
Представляет сущность корзины, куда пользователь складывает товары, которые он хотел бы приобрести
* ProductId - внешний ключ, ссылающийся на товар
* UserId - внешний ключ, ссылающийся на пользователя

#### Таблица Comment
Сущность комментриев пользователей под товарами
* Id - уникальный индефикатор комментария
* CreateDate - дата создания комментария
* Text - текст комментария
* ProductId - внешний ключ, ссылающийся на товар под которым был оставлен комментарий
* UserId - внешний ключ, ссылающийся на пользователя который оставил комментарий

#### Таблица SearchHistory
Представляет сущность истори поиска, где сохраняются товары, которые просматривал пользователь
* ProductId - внешний ключ, ссылающийся на товар
* UserId - внешний ключ, ссылающийся на пользователя

#### Таблица Favorites
Представляет сущность списка избранных товаров, где сохраняются товары, которые понравились пользователю
* ProductId - внешний ключ, ссылающийся на товар
* UserId - внешний ключ, ссылающийся на пользователя

#### Таблица PickupPoint
Представляет из себя сущность пункта выдачи товаров
* Id - уникальный индефикатор пункта выдачи товаров
* Place - адрес нахождения пункта выдачи
* TimeToWork - время закрытия пункта выдачи

#### Таблица StoreHouse
Представляет из себя сущность пункта хранения, откуда будут доставляться товары на пункт выдачи
* Id - уникальный индефикатор пункта хранения
* Place - адрес нахождения пункта хранения

#### Таблица Distance
Представляет из себя связь пунктов выдачи и пунктов хранения, в виде дистанции с помощью которой можно сказать, когда будет товар
* Distance - дистанция между пунктами выдачи и пунктами хранения
* StorehouseId - уникалный индефикатор пункта хранения товаров
* PickupPointId - уникальный индефикатор пункта выдачи

#### Таблица Market
Представляет из себя сущность магазина/продавца товаров
* Id - уникальный индефикатор продавца/магазина
* Name - Название магазина/продавца
* Rating - рейтинг магазина/продавца

