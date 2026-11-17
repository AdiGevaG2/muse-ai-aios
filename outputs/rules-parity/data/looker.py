import configparser, json, os, sys, urllib.request, urllib.parse

cfg = configparser.ConfigParser()
cfg.read(os.path.expanduser("~/.looker.ini"))
sec = cfg[cfg.sections()[0]]
BASE = sec["base_url"].rstrip("/")
if not BASE.endswith("/api/4.0"):
    BASE = BASE + "/api/4.0"


def req(method, path, data=None, token=None, raw=False):
    url = BASE + path
    body = None
    headers = {}
    if token:
        headers["Authorization"] = "token " + token
    if data is not None:
        if isinstance(data, dict) and method == "POST" and path == "/login":
            body = urllib.parse.urlencode(data).encode()
            headers["Content-Type"] = "application/x-www-form-urlencoded"
        else:
            body = json.dumps(data).encode()
            headers["Content-Type"] = "application/json"
    r = urllib.request.Request(url, data=body, headers=headers, method=method)
    with urllib.request.urlopen(r, timeout=300) as resp:
        txt = resp.read().decode()
    return txt if raw else json.loads(txt)


tok = req("POST", "/login", {"client_id": sec["client_id"], "client_secret": sec["client_secret"]})["access_token"]

cmd = sys.argv[1]
if cmd == "models":
    for m in req("GET", "/lookml_models", token=tok):
        print(m["name"], [e["name"] for e in m.get("explores", [])])
elif cmd == "fields":
    e = req("GET", f"/lookml_models/{sys.argv[2]}/explores/{sys.argv[3]}", token=tok)
    pat = sys.argv[4].lower() if len(sys.argv) > 4 else ""
    for kind in ("dimensions", "measures"):
        for f in e["fields"][kind]:
            if pat in f["name"].lower() or pat in (f.get("label") or "").lower():
                print(kind[0], f["name"], "|", f.get("label"), "|", f.get("type"))
elif cmd == "query":
    q = json.loads(sys.argv[2])
    print(req("POST", "/queries/run/csv", q, token=tok, raw=True))
