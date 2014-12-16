library(httr)
library(httpuv) # manually set up the packages into R#


# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
github<- oauth_endpoints("github")

# 2. Register an application at https://github.com/settings/applications;
#    Use any URL you would like for the homepage URL (http://github.com is fine)
#    and http://localhost:1410 as the callback url
#
#    Insert your client ID and secret below - if secret is omitted, it will
#    look it up in the GITHUB_CONSUMER_SECRET environmental variable.
myapp<- oauth_app("github", key="88d5ba2e62da379649c4",secret="2f595d9f8abfefd945a09838120540d5973a1b56")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(github, myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/rate_limit", gtoken)
stop_for_status(req)
content(req)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)
