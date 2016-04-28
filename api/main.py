import rauth
import time

def main():
    locations = [ (37.8716452, -122.253818) ] #39.98,-82.98),(42.24,-83.61),(41.33,-89.13)]
    api_calls = []
    print("Using locations %s" % locations)
    for lat,lon in locations:
        params = get_search_parameters(lat,lon)
        api_calls.append(get_results(params))
        #Be a good internet citizen and rate-limit yourself
        time.sleep(1.0)
    return api_calls
    ##Do other processing

def get_results(params):
    with open("secret.txt") as infile:
        lines = infile.readlines()
    keys = [line.strip() for line in lines]
    #Obtain these from Yelp's manage access page
    consumer_key = keys[0]
    consumer_secret = keys[1]
    token = keys[2]
    token_secret = keys[3]

    session = rauth.OAuth1Session(
        consumer_key = consumer_key
        ,consumer_secret = consumer_secret
        ,access_token = token
        ,access_token_secret = token_secret)

    request = session.get("http://api.yelp.com/v2/search",params=params)

    #Transforms the JSON API response into a Python dictionary
    data = request.json()
    session.close()

    return data

def get_search_parameters(lat,long):
    #See the Yelp API for more details
    params = {}
    params["term"] = "restaurant"
    params["ll"] = "{},{}".format(str(lat),str(long))
    params["radius_filter"] = "2000"
    params["limit"] = "10"
    return params

if __name__=="__main__":
    data = main()
    print(data)