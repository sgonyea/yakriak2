# Welcome to My Riak MapReduce Demo Rails App!

## Source Data

Map Reduce will be used for data analysis, with the [Enron Email Dataset][enron_data] as the focus.

## How to Get Started

Make sure you have several GB of hard-disk space available.

* Clone this repo and install dependencies:

        git clone git://github.com/aitrus/lapreso.git
        cd lapreso
        export LAPRESO=`pwd`
        bundle install

* Fetch the Enron Email Dataset

        # Make the file hidden - TextMate's Project Pane *will* choke on this file, if not done so
        mkdir tmp/.enron && cd tmp/.tmp_enron
        curl -O http://www.cs.cmu.edu/~enron/enron_mail_082109.tar.gz

        # And wait
        tar zxf enron_mail_082109.tar.gz

        mv maildir ../.maildir && cd .. && rm .tmp_enron

* [Install Riak Search][install_rs]. I suggest building a development release.

        # Pre-Requisites: erlang (possibly mercurial?)
        cd $LAPRESO/db
        curl -O http://downloads.basho.com/riak-search/riak-search-0.13/riak_search-0.13.0.tar.gz
        tar zxf riak_search-0.13.0.tar.gz

        rm riak_search-0.13.0.tar.gz
        mv riak_search-0.13.0 riak_search
        cd riak_search

        make all devrel

* Start Riak

        # Set your ulimits, if on a Mac (I suggest adding this to your .profile)
        ulimit -n 8192

        # Fire up the three dev nodes you built
        dev/dev1/bin/riaksearch start
        dev/dev2/bin/riaksearch start
        dev/dev3/bin/riaksearch start

        # Make em gossip
        dev/dev2/bin/riaksearch-admin join dev1@127.0.0.1
        dev/dev3/bin/riaksearch-admin join dev1@127.0.0.1

* Bring in a [load balancer][pen], to simulate something not so lob-sided (not necessary, but will be assumed)

        cd $LAPRESO/db
        curl -O http://siag.nu/pub/pen/pen-0.18.0.tar.gz   # Make this a brew package?
        tar zxf pen-0.18.0.tar.gz

        rm pen-0.18.0.tar.gz
        mv pen-0.18.0 pen
        cd pen

        ./configure && make

        cd $LAPRESO
        # Port 8098 is the default web port; we'll have the load balancer sit here and route it to our dev nodes
        db/pen/pen -x 500 -p tmp/pen-8098.pid localhost:8098 8098 localhost:8091 localhost:8092 localhost:8093

* Feed Data

I recycled some of the script used by [Tim Dysinger][dysinger].

        rake data:load

# Thanks To

## Source Data
Thanks to [Infochimps][infochimps] for pointing me at the data, and [dysinger][dysinger] for redirecting me to mail-trends. [Carnegie Melon][enron_data] and the [mail-trends][mailtrends] project.


[infochimps]:   http://infochimps.com/datasets/enron-email-dataset--2
[enron_data]:   http://www.cs.cmu.edu/~enron/
[dysinger]:     http://dysinger.net/
[mailtrends]:   http://code.google.com/p/mail-trends/source/browse/#svn/trunk
[install_rs]:   https://wiki.basho.com/display/RIAK/Riak+Search+-+Installation+and+Setup
[pen]:          http://siag.nu/pen/

