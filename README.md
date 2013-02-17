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

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
