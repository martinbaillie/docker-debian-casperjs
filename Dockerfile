FROM debian:jessie

ENV VERSION_PHANTOMJS 1.9.8-linux-x86_64
ENV VERSION_CASPERJS 1.1-beta3

# Deps
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y curl git bzip2 libfreetype6 libfontconfig python && \
    rm -rf /var/lib/apt/lists/*

# PhantomJS
RUN curl -sSLk https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$VERSION_PHANTOMJS.tar.bz2 | \
    tar xjC /opt && \
    ln -s /opt/phantomjs-$VERSION_PHANTOMJS /opt/phantomjs && \
    ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs

# CasperJS
RUN git clone --depth 1 -b $VERSION_CASPERJS https://github.com/n1k0/casperjs.git /opt/casperjs-$VERSION_CASPERJS && \
    ln -s /opt/casperjs-$VERSION_CASPERJS /opt/casperjs && \
    ln -s /opt/casperjs/bin/casperjs /usr/bin/casperjs

ENTRYPOINT ["/usr/bin/casperjs"]
