#code imported from https://gist.github.com/AO8/faa3f52d3d5eac63820cfa7ec2b24aa7
# and hacked about by LB for ATCL mungeing purposes

import urllib.request
import json
import textwrap
import time

counter=0
searches=0
notFound=0
handsOff=0

apiKey=""
base_api_link = "https://www.googleapis.com/books/v1/volumes?q="

S = open('searches2.txt','r')
print("<listBibl>")
for srch in S:
#    print("Search:",srch)
    counter=counter+1
    if counter >= 40:
        time.sleep(200)
        print("<!-- Sleeping -->")
        searches=searches+counter
        counter=0
#    srch=srch.split('\n')
    searchString=srch.split(':')[1]
    textId=srch.split(':')[0]
    searchString=searchString.split('\n')[0]
#    print(base_api_link + searchString +apiKey)
    with urllib.request.urlopen(base_api_link + searchString +apiKey) as f:
        text = f.read()

    decoded_text = text.decode("utf-8")
#    print(decoded_text)
    obj = json.loads(decoded_text) # deserializes decoded_text to a Python object
    totalItems =  obj["totalItems"]
    if totalItems == 0:
        print("<!-- No hits found for",srch, "-->")
        notFound=notFound+1
    else:
        volume_info = obj["items"][0] 

        access = volume_info["accessInfo"]["publicDomain"]
        download = volume_info["volumeInfo"]["canonicalVolumeLink"]

        if access:
            print("<bibl xml:id='",textId,"'>")
            print("<ref target='",download,"'/>")
            print("<title>", volume_info["volumeInfo"]["title"],"</title>")
            if obj["items"][0]["volumeInfo"]["authors"]:
                authors = obj["items"][0]["volumeInfo"]["authors"]
                print("<author>", ",".join(authors), "</author></bibl>\n")
            else:
                print("<author/>")

        else:
            print("<!--No access for", srch.strip(), "-->")
            handsOff=handsOff+1

#        print("\nPublic Domain:", volume_info["accessInfo"]["publicDomain"])
#        print("\nDownload:", volume_info["volumeInfo"]["canonicalVolumeLink"])
#        print("\nLanguage:", volume_info["volumeInfo"]["language"])
        #    print("\nPage count:", volume_info["volumeInfo"]["pageCount"])
S.close
print("</listBibl>")
print("<!-- ",searches, " searches; ",notFound, " not found; ", handsOff, " not accessible -->")



