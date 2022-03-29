# SSH TEST BOX
It's simple docker image that expose ssh and http server

## CREATE LOCAL SSH KEYS
```
ssh-keygen -t rsa -b 4096
#Generating public/private rsa key pair.
#Enter file in which to save the key (********/.ssh/id_rsa): ./id_rsa
#Enter passphrase (empty for no passphrase): 
#Enter same passphrase again: 
#Your identification has been saved in ./id_rsa.
#Your public key has been saved in ./id_rsa.pub.
```

## BUILD
```
$Env:GOOS="linux"
go build github.com/dwilkolek/ssh-test-box
docker build . -t test-ssh-box:latest
```

## RUN

```
# just ssh
docker run -p 22:22 test-ssh-box:latest

# ssh+http
docker run -p 22:22 -p 8080:8080 test-ssh-box:latest
```
## CONNECT
- ssh at port 22
- http server at 8080

## TUNNEL
`ssh -N -L 9999:localhost:8080 sshuser@localhost -i ./id_rsa`

## EXAMPLE API CALL
GET `http://localhost:9999/api`
```
Path /api 
 HOST localhost:9999 
 User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:98.0) Gecko/20100101 Firefox/98.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8
Accept-Language: pl,en-US;q=0.7,en;q=0.3
Connection: keep-alive
Upgrade-Insecure-Requests: 1
Sec-Fetch-User: ?1
Accept-Encoding: gzip, deflate
Dnt: 1
Sec-Fetch-Dest: document
Sec-Fetch-Mode: navigate
Sec-Fetch-Site: none
```

