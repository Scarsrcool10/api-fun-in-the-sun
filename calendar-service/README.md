[< Back to Assignment](../README.md)

## Calendar (Node / Express)
This service contains information about a users upcoming meetings.
 
### Events Endpoints

**Host:** `http://localhost:8000`

**Docker Network Host:** `http://calendar-service:8000`

**Endpoints:**
- For all events by user_id: `/events`
- For all events by date range: `/events_by_date_range`

**Method:** GET

**Description:** Retrieve a list of upcoming events for the user

### Request Parameters for `/events`

| Parameter | Type | Requred | Description   |
| --------- | ---- | ------- | ------------- |
| `user_id` | int  | Yes     | The user's ID |


### Request Parameters for `/events_by_date_range`

| Parameter    | Type   | Requred | Description |
|--------------|--------| ------- |-------------|
| `start_date` | string | Yes     | mm/dd/yyyy  |
| `end_date`   | string | Yes     | mm/dd/yyyy  |


### Example Responses

**Success**
```json
{
    "events":
        [
            {"id": 1, "name": "1on1", "duration": 30, "attendees": 2, "date": "MM/DD/YYY"},
            {"id": 2, "name": "hangout", "duration": 60, "attendees": 5, "date": "MM/DD/YYY"},
            ...
        ]
}
```

**Error**
```json
{
    "message": <error message>
}
```

### Response Codes

| Status Code | Description      |
|-------------|------------------|
| 200         | OK               |
| 400         | Bad Request      |
| 404         | Record not Found |
