FROM php:8.2.11-fpm-alpine

RUN \
    apk add icu icu-dev libxslt libxslt-dev libffi libffi-dev libpq libpq-dev gmp gmp-dev \
    && docker-php-ext-install opcache \
        # Number formatting in our own application templates requires intl.
        intl \
        # symfony/messenger requires PCNTL for graceful shutdown of queue workers.
        pcntl \
        # Pheanstalk requires sockets extension otherwise it throws SocketException with "Unknown error" (CLUB-250-B6).
        sockets \
        # lorenzo/pinky requires XSL extension.
        xsl \
        # amphp/hpack can benefit from FFI extension.
        ffi \
        # amphp/postgres requires either pecl-pq or ext-pgsql.
        pgsql \
        # Phinx requires pdo_pgsql extension.
        pdo_pgsql \
        # xpaw/steamid requires GMP extension.
        gmp \
    # All dev packages can be removed post-compile, however the main packages cannot.
    && apk del icu-dev libxslt-dev libffi-dev libpq-dev gmp-dev
