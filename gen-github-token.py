import json
import jwt
import os
import requests
import sys
import time

private_key = """-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEA4NJ8LFqB5mH5Kc5wqK7ydRxCJKBNz87WIjXFGqwrW/trJ3GX
Qa9ruzs9fTZXxA087vxKjLS/s8OO1pT6jwzERKyr/45pFXziOqHC+AHA1HGffB5I
wEAmbrkjEkkbQR6pLhoolNIekelt7EenGgv5Osb29qby5xCh6or21r80h7h3cO6h
Lm9ZC+Lha98AkDqn2CPZS5Q9YYeREtsboZtjnmbBQB7g02p52uGV11UP88aCTTH+
EP5id2Q7h+uNjalk28WVk8i5IED+Fgj3x/hA10sNCojlDs5yXyyFOcVA15neAcqd
U2gEb2pwDQ8XYA1SEZvZ9AqqWlkRQtQC8myg+QIDAQABAoIBACocw027lmGFMJr4
JHo0aw4swOcDcA/g+pNl5wnb/jM4oRW+XUrchR2JNzdhGoeKw0Mw1vYMVWxi0Tq4
pUZuacVDYuR31I9F2UqKSm8SRQCGWA1zzsTUP162Jy+hqg1EpQQRulBGG5vRUdnU
giSK4aB07IW/N/i4UNwSM7J+FmTletXRQuDzbkN8W0/ApR4yPmVAqRL7r05ekhwN
SZgD6e8x55B7db9BwQ3Dr1DIFqAgc/Zo4wMUDVxQpMKdu1g7qIGjK18LzI1vGWsp
RCzNirCCxaNU8uhi9IsVA64V/H3LoUSohlhsA/Wmg1Z90JQBpdZNQzB1ZY4fyV7N
m54ehAECgYEA/a5tk6b2fQhrQretqXMVSEKRbORKm5oGeTJhjYstvIKrmTS8V+8e
CyFfbt5aEmgetdz2akiTnTS13GyhxayQuZUkmS4G6sLN2+AA4l2iP13J4TK5gkXP
pgPor0fTQhk/UJOFnomNWIdlrG6v8iCiHJp0y4I6TAkiR09O2v5n4OECgYEA4uCI
C5CEIwWqMcMKnh++wsZjqaMp4veDFdH5JTVCp0syjIJwKxOwRgc8T8CwGKaeHuA9
t2bXXhGXaPcIwn/wXUGMHHdKnV/1nkj+gTpA1DiTz7WOW+rSpwcRJTU57aXpILw5
lpVro3JaKQezVJbf3iGWd62cMTMoHlAhwjFeCxkCgYEAwnNApQw3JlIcvbBDmn6P
UqtMA5beJXWj/qSCqFeFwFi9JhuJPzIX6lozZ61ih3duCuMLsx5coAT2XbabLgV/
jfFnc08XmD2oRCDpLJqvMjk29LrH/bZ7W3rlke3RXnox0RazNnmjcbefVNQnY8Zl
3Nz8J75z5zKdJuIAxNZ7U6ECgYBnutj40J5ZlOF31wEnwsPpMeOnT95600ev1kzf
YjaTXqJB8/FtAJd7rRs6K5NX8fYhj80n6XFWpRxg9XGf2/b97FYvPatzwMgAEseq
NgQmA6gxM4VfKUIe8/A23tsZeN3aBbUe0DpihIoMcGThrAm2+gxds5bSN92D3odQ
zll9IQKBgC6r/me07OJnRSkx45hXjc4WDyioLIKI5UDgO5cUyFpkR1KnjEUVYvUj
KO6TysJs6iLDFDSWb/P3i9qvHWWw6ED3KCPzPKTfBdOYaTnJernSNjP0EwGpUFZz
43fJ1g3dCmZaqjtdISVS39aF3+jU5gOv2S2pT4FfJeAYnB7ip16j
-----END RSA PRIVATE KEY-----"""

payload = {
  # issued at time
  "iat": int(time.time()),
  # JWT expiration time (10 minute maximum)
  "exp": int(time.time()) + (10 * 60),
  # GitHub App's identifier
  "iss": 17077
}
github_jwt = jwt.encode(payload, private_key, algorithm="RS256")

headers = {
    "Authorization": "Bearer " + github_jwt,
    "Accept": "application/vnd.github.machine-man-preview+json"
}

r = requests.post("https://api.github.com/app/installations/328056/access_tokens", headers=headers)

github_token = json.loads(r.text)["token"]

if r.status_code != 201:
    print r.text
    sys.exit(1)

f = open("GITHUB_TOKEN", "w")
f.write(github_token)
