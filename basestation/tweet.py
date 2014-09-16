from twython import Twython

twitter = Twython(APP_KEY, APP_SECRET
                  OAUTH_TOKEN, OAUTH_TOKEN_SECRET)

twitter.update_status(status='ALERT: Suspected sheep in labour!')