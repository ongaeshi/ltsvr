# ltsvr - LTSV viewer for Ruby

LTSV Viewer made with Ruby. 

* Select label `-k host,ua`, `-i time,req`
* Filtering keyword `-f ua=Mozilla`
* Go to LTSV website `--web`

Inspired by [ltsview](https://github.com/naoya/perl-Text-LTSV/blob/master/bin/ltsview).


## Installation

    $ gem install ltsvr
    
## Usage

    $ ltsvr -h
    ltsvr [OPTION] [FILE]...
    -k, --keywords LABEL             Display keywords   (-k host,ua)
    -i, --ignore-keywords LABEL      Ignore keywords    (-i time,req)
    -f, --filter FILTER              Filtering keywords (-f host=192.168.1.1,ua=Mozilla)
        --web                        Go to website (http://ltsv.org)
        
## Sample

Specify LTSV file.

```
$ ltsvr /path/to/log
host:127.0.0.1, ident:-, user:frank, time:[10/Oct/2000:13:55:36 -0700], req:GET /apache_pb.gif HTTP/1.0, status:200, size:2326, referer:http://www.example.com/start.html, ua:Mozilla/4.08 [en] (Win98; I ;Nav)
host:127.0.0.2, ident:-, user:mike, time:[10/Oct/2000:13:55:36 -0700], req:GET /apache_pb.gif HTTP/1.0, status:200, size:2326, referer:http://www.example.com/start.html, ua:Mozilla/4.08 [en] (Win98; I ;Nav)
host:127.0.0.3, ident:-, user:takashi, time:[10/Oct/2000:13:55:36 -0700], req:GET /apache_pb.gif HTTP/1.0, status:200, size:2326, referer:http://www.example.com/start.html, ua:Mozilla/4.08 [en] (Win98; I ;Nav)
host:127.0.0.4, ident:-, user:frank, time:[10/Oct/2000:13:55:36 -0700], req:GET /apache_pb.gif HTTP/1.0, status:200, size:2326, referer:http://www.example.com/index.html, ua:Mozilla/4.08 [en] (Win98; I ;Nav)
```

Select label.

```
$ ltsvr /path/to/log -k host,user
host:127.0.0.1, user:frank
host:127.0.0.2, user:mike
host:127.0.0.3, user:takashi
host:127.0.0.4, user:frank
```

Filtering option.

```
$ ltsvr /path/to/log -k host,user -f user=frank
host:127.0.0.1, user:frank
host:127.0.0.4, user:frank
```

Ignore label.

```
$ ltsvr /path/to/log -i host,ident,status,time,req,size,ua -f referer=start.html
user:frank, referer:http://www.example.com/start.html
user:mike, referer:http://www.example.com/start.html
user:takashi, referer:http://www.example.com/start.html
```

Use pipe.

```
$ tail -f /path/to/log | ltsvr -f user=takashi
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
