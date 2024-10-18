# テーブル設計

## users テーブル

| Column             | Type   | Options                         |
| ------------------ | ------ | ------------------------------- |
| email              | string | null: false, unique: true      |
| encrypted_password | string | null: false                    |
| last_name          | string | null: false                    |
| first_name         | string | null: false                    |
| last_name_kana     | string | null: false                    |
| first_name_kana    | string | null: false                    |
| nickname           | string | null: false                    |
| profile            | text   | null: false                    |
| occupation         | text   | null: false                    |
| position           | text   | null: false                    |

### items テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| user               | references | null: false, foreign_key: true |
| category_id        | integer    | null: false                    |
| item_name          | string     | null: false                    |
| description        | text       | null: false                    |
| condition          | string     | null: false                    |
| shopping_free      | boolean    | null: false                    |
| region_id          | integer    | null: false                    |
| delivery_time      | string     | null: false                    |
| price              | integer    | null: false                    |

### purchases テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |

### addresses テーブル

| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| postal_code        | string     | null: false                    |
| prefecture_id      | integer    | null: false                    |
| city               | string     | null: false                    |
| address_line       | string     | null: false                    |
| building           | string     |                                |
| phone_number       | string     | null: false                    |
| purchase_id        | references | null: false, foreign_key: true |
