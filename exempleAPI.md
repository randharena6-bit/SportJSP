///basket

POST /v1/nba/clips/match
{ playType: "steal", players: ["M. Robinson"] }
{ match: "MITCHELL ROBINSON'S EFFORT HERE IS UNREAL" }

///Football
{
  "data": [
    {
      "id": 489389,
      "round": "Regular Season - 32",
      "date": "2023-05-20T15:30:00.000Z",
      "country": {
        "code": "FR",
        "name": "France",
        "logo": "https://example.com/logos/country/FR.png"
      },
      "awayTeam": {
        "id": 553,
        "logo": "https://example.com/logos/team/553.png",
        "name": "Montpellier"
      },
      "homeTeam": {
        "id": 553,
        "logo": "https://example.com/logos/team/553.png",
        "name": "Montpellier"
      },
      "league": {
        "id": 133,
        "season": 2023,
        "name": "Ligue 1",
        "logo": "https://example.com/logos/league/133.png"
      },
      "state": {
        "description": "Second half",
        "clock": 67,
        "score": {
          "current": "3 - 1",
          "penalties": "6 - 4"
        }
      }
    }
  ],
  "pagination": {
    "totalCount": 490,
    "offset": 20,
    "limit": 100
  },
  "plan": {
    "tier": "BASIC",
    "message": "Some results might be hidden with FREE tier. Check your API coverage for more information: https://rapidapi.com/highlightly-api-highlightly-api-default/api/sport-highlights-api/details"
  }
}

///Live Foot
[
  {
    "team": {
      "id": 13394673,
      "logo": "https://example.com/logo/preview/66311.13394673",
      "name": "Tersana"
    },
    "time": "45+1",
    "type": "Goal",
    "playerId": 63606907,
    "player": "M. Mamdouh",
    "assistingPlayerId": 0,
    "assist": "J. Johanson",
    "substituted": "string"
  }
]

///News API
151b834324ec4c9fba60f7b37aa8e3e3

exemple : https://newsapi.org/v2/top-headlines?category=sports

https://www.thesportsdb.com/api/v1/json/YOUR_API_KEY_GOES_HERE/searchteams.php?t=Arsenal

////Gemini APIs
AIzaSyBbwAQeXr2rdNbEV_SwzlmJSK8xVm_Eong

curl "https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent" \
  -H 'Content-Type: application/json' \
  -H 'X-goog-api-key: AIzaSyBbwAQeXr2rdNbEV_SwzlmJSK8xVm_Eong' \
  -X POST \
  -d '{
    "contents": [
      {
        "parts": [
          {
            "text": "Explain how AI works in a few words"
          }
        ]
      }
    ]
  }'

  /// youtube 
  {
  "kind": "youtube#liveBroadcast",
  "etag": etag,
  "id": string,
  "snippet": {
    "publishedAt": datetime,
    "channelId": string,
    "title": string,
    "description": string,
    "thumbnails": {
      (key): {
        "url": string,
        "width": unsigned integer,
        "height": unsigned integer
      }
    },
    "scheduledStartTime": datetime,
    "scheduledEndTime": datetime,
    "actualStartTime": datetime,
    "actualEndTime": datetime,
    "isDefaultBroadcast": boolean,
    "liveChatId": string
  },
  "status": {
    "lifeCycleStatus": string,
    "privacyStatus": string,
    "recordingStatus": string,
    "madeForKids": string,
    "selfDeclaredMadeForKids": string,
  },
  "contentDetails": {
    "boundStreamId": string,
    "boundStreamLastUpdateTimeMs": datetime,
    "monitorStream": {
      "enableMonitorStream": boolean,
      "broadcastStreamDelayMs": unsigned integer,
      "embedHtml": string
    },
    "enableEmbed": boolean,
    "enableDvr": boolean,
    "recordFromStart": boolean,
    "enableClosedCaptions": boolean,
    "closedCaptionsType": string,
    "projection": string,
    "enableLowLatency": boolean,
    "latencyPreference": boolean,
    "enableAutoStart": boolean,
    "enableAutoStop": boolean
  },
  "statistics": {
    "totalChatCount": unsigned long
  },
  "monetizationDetails": {
      "cuepointSchedule": {
        "enabled": boolean,
        "pauseAdsUntil": datetime,
        "scheduleStrategy": string,
        "repeatIntervalSecs": unsigned integer,
      }
    }
  }


