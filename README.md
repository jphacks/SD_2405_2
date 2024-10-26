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
    "display_name": "Sample Item",
    "generic_name": "Sample Generic",
    "status": "packed",
    "user_id": 1
  },
  "category_name": "aaa",
  "shelf_life_days": 30
}
```

### [GET] /items?user_id=xx
userの持つ商品情報を一覧取得する
```
response:
[
    {
        "id": 5,
        "display_name": "Sample Item",
        "generic_name": "Sample Generic",
        "status": "packed",
        "category_name": "aaa",
        "expiry_date": null
    },
    {
        "id": 6,
        "display_name": "Sample Item",
        "generic_name": "Sample Generic",
        "status": "packed",
        "category_name": "aaa",
        "expiry_date": null
    },
    {
        "id": 7,
        "display_name": "Sample Item",
        "generic_name": "Sample Generic",
        "status": "packed",
        "category_name": "aaa",
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
        "name": "aaa",
        "created_at": "2024-10-26T09:50:06.749Z",
        "updated_at": "2024-10-26T09:50:06.749Z"
    }
]
```
