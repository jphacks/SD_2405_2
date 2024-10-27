## API examples
### [POST] /users
ユーザーの登録を行う
```
request:
{
  "user": {
    "name": "John Doe",
    "email": "john@example.com",
  }
}
response:
{
  message: "User created successfully",
  user: @user }, status: :created
}
```

### [GET] /users
ユーザーの一覧情報を取得する

### [POST] /items
商品情報を登録する
```
request:
{
  "item": {
    "display_name": "Sample Item2",
    "generic_name": "Sample",
    "status": "packed",
    "user_id": 1
  },
  "shelf_life_days": 30,
  "category_names": ["Food", "Shampoo"]
}
```

### [PATCH] /items/update_status
商品のステータス情報を更新する
```
{
    "display_name": "Sample Item2",
    "status": "unpacked"
}
```

### [GET] /items?user_id=xx
userの持つ商品情報を一覧取得する
```
response:
[
    {
        "id": 1,
        "display_name": "Sample Item",
        "generic_name": "Sample",
        "status": "packed",
        "category_names": [
            "Food",
            "Snack"
        ],
        "expiry_date": "2024-11-25"
    },
    {
        "id": 2,
        "display_name": "Sample Item2",
        "generic_name": "Sample",
        "status": "packed",
        "category_names": [
            "Food",
            "Shampoo"
        ],
        "expiry_date": "2024-11-25"
    }
]
```

### [GET] /categories
全てのカテゴリー情報を取得する
```
response:
[
    {
        "id": 1,
        "display_name": "Sample Item",
        "generic_name": "Sample",
        "status": "packed",
        "category_names": [
            "Food",
            "Snack"
        ],
        "expiry_date": "2024-11-25"
    },
    {
        "id": 2,
        "display_name": "Sample Item2",
        "generic_name": "Sample",
        "status": "packed",
        "category_names": [
            "Food",
            "Shampoo"
        ],
        "expiry_date": "2024-11-25"
    }
]
```
