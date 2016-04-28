import json
from contextlib import ContextDecorator, contextmanager

header = '''<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>'''

closing = '''</array>
</plist>'''

class plist(ContextDecorator):
    def __enter__(self):
        print(header)
        return self

    def __exit__(self, *exc):
        print(closing)
        return False

@plist()
def function():
    print('The bit in the middle')

@contextmanager
def tag(name):
    print("<%s>" % name)
    yield
    print("</%s>" % name)

@plist()
def main_thread():
    with open("main.json") as infile:
        line = infile.readlines()[0]
    obj = json.loads(line)
    data = obj["businesses"]
    for biz in data:
        name = "%s" % getName(biz)
        address = "%s" % getAddress(biz)
        lat, lon = getCoords(biz)
        with tag("dict"):
            print("<key>name</key>")
            print("<string>%s</string>" % name)
            print("<key>location</key>")
            with tag("array"):
                print("<real>%s</real>" % lat)
                print("<real>%s</real>" % lon)
            print("<key>address</key>")
            print("<string>%s</string>" % address)

def main():
    with open("main.json") as infile:
        line = infile.readlines()[0]
    obj = json.loads(line)
    data = obj["businesses"]
    for biz in data:
        print("Name: %s" % getName(biz))
        print("Address: %s" % getAddress(biz))
        print("Coordinate: %s, %s" % getCoords(biz))

def getName(obj):
    out = "None Found"
    try:
        out = obj["name"]
    except Exception as e:
        print(e)
    return out

def getCoords(obj):
    out = (None, None)
    try:
        cord = obj["location"]["coordinate"]
        out = (cord["latitude"], cord["longitude"])
    except Exception as e:
        print(e)
    return out

def getAddress(obj):
    out = "None Found"
    try:
        out = obj["location"]["display_address"][0]
    except Exception as e:
        print(e)
    return out

if __name__ == '__main__':
    # main()
    main_thread()