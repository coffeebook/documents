# REST API Testing

Work with several or many web applications and soon enough, you'll get into contact with (RESTful) web services. This document contains useful information that you might otherwise find harder to come by.

## [Curl](http://curl.haxx.se/)

In order to quickly test functionality, it's often easier to use a command line tool. The program named [curl](http://curl.haxx.se/) is fit for the job! So first, we'll demonstrate a few of the basic operations of curl so you may be better understand its purpose.

From their website we learn that:

> curl is a command line tool for transferring data with URL syntax, supporting DICT, FILE, FTP, FTPS, Gopher, HTTP, HTTPS, IMAP, IMAPS, LDAP, LDAPS, POP3, POP3S, RTMP, RTSP, SCP, SFTP, SMTP, SMTPS, Telnet and TFTP. curl supports SSL certificates, HTTP POST, HTTP PUT, FTP uploading, HTTP form based upload, proxies, cookies, user+password authentication (Basic, Digest, NTLM, Negotiate, kerberos...), file transfer resume, proxy tunneling and a busload of other useful tricks. 

Run it with an URL as parameter minimum 

```sh
curl google.com
```

and you'll see something like:

```html
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>.
</BODY></HTML>
```

Notice it automatically detects the correct protocol - HTTP - and know that providing it with [http://google.com](http://google.com) would have caused the same effect.

You friend through this all is the shell, the command `curl` given on the prompt readline `$` will yield the default output:

```sh
$ curl
curl: try 'curl --help' or 'curl --manual' for more information
```



