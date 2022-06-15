export default {
  comments: [
    {
      "id": 1,
      "post_id": 1,
      "content": "test",
      "user": {
          "id": 1,
          "name": "Rudy Zidan"
      },
      "reaction_summary": {
          "likes": 1,
          "smiles": 1,
          "thumbs_up": 0
      },
      "reactions": [
          {
              "id": 2,
              "comment_id": 3,
              "user_id": 2,
              "reaction": "like"
          },
          {
              "id": 5,
              "comment_id": 3,
              "user_id": 1,
              "reaction": "smile"
          }
      ]
    },
    {
        "id": 2,
        "post_id": 1,
        "content": "Hello",
        "user": {
            "id": 1,
            "name": "Rudy Zidan"
        },
        "reaction_summary": {
            "likes": 0,
            "smiles": 1,
            "thumbs_up": 1
        },
        "reactions": [
            {
                "id": 6,
                "comment_id": 4,
                "user_id": 1,
                "reaction": "smile"
            },
            {
                "id": 7,
                "comment_id": 4,
                "user_id": 2,
                "reaction": "thumbsup"
            }
        ]
    }
  ]
}