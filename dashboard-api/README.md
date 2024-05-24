## Dashboard API (Ruby / Rails)
This services gives a detailed summary about a user, including calendar events and subscription information


### Summary Endpoint

**Host Endpoint:** `http://localhost:8000/summary

**Docker Network Endpoint:** `http://dashboard-api:8000/summary`

**Method:** GET

**Description:** Retrieve a detailed summary for a given user

### Request Parameters

| Parameter | Type | Requred | Description   |
| --------- | ---- | ------- | ------------- |
| `user_id` | int  | Yes     | The user's ID |

### Example Responses

**Success**
```json
{
  "user_summary_data":
    {
      "id":1,
      "first_name":"Michael",
      "last_name":"Scott",
      "number_of_past_meetings":3,
      "future_calendar_events":
        [
          {
            "name":"1on1",
            "date":"3/28/2024, 10:00:23 AM",
            "duration":60,
            "attendees":2
          }
        ],
      "subscription_data":
        {
          "renewal_date":"04/23/2024",
          "days_until_renewal":29,
          "subscription_cost":"$15.00",
          "pricing_plan":"monthly"
        }
    }
}
```

**Error**
```json
{
    "message": <error message>
}
`
