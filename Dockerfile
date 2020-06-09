# Docker image for TYPO3 CMS
# Copyright (C) 2016-2020  Martin Helmich <martin@helmich.me>
#                          Tobias Birmili <birmili@mecodia.de>
#                          and contributors <https://github.com/martin-helmich/docker-typo3/graphs/contributors>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
ARG PHP_VERSION=7.4-apache-buster
ARG BUILD_VERSION=unknown

FROM php:${PHP_VERSION}
LABEL maintainer="mecodia GmbH <it@mecodia.de>"
ENV BUILD_VERSION=${BUILD_VERSION}

# Use the default production configuration
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Install PHP and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    cron \
    # Configure PHP
    libxml2-dev libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libpq-dev \
    zlib1g-dev \
    libzip-dev \
    # Install required 3rd party tools
    poppler-utils \
    ghostscript \
    graphicsmagick && \
    # Configure extensions
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) mysqli soap gd zip opcache intl pgsql pdo_pgsql && \
    echo 'always_populate_raw_post_data = -1\nmax_execution_time = 240\nmax_input_vars = 1500\nupload_max_filesize = 32M\npost_max_size = 32M' > /usr/local/etc/php/conf.d/typo3.ini && \
    echo 'log_errors = On\nerror_log = /dev/stderr' >> /usr/local/etc/php/conf.d/typo3.ini && \
    # Configure Apache as needed
    a2enmod rewrite && \
    apt-get clean && \
    apt-get -y purge \
    libxml2-dev libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    zlib1g-dev \
    libzip-dev && \
    rm -rf /var/lib/apt/lists/* /usr/src/*

# Install Typo3
ARG TYPO_VERSION=9
WORKDIR /var/www/html
RUN wget -nv -O - https://get.typo3.org/${TYPO_VERSION} | tar -xzf - && \
    ln -s typo3_src-* typo3_src && \
    ln -s typo3_src/index.php && \
    ln -s typo3_src/typo3 && \
    mkdir typo3temp && \
    mkdir typo3conf && \
    mkdir fileadmin && \
    mkdir uploads && \
    chown -R www-data. .

# Copy default .htaccess (ln version for typo3 <= 8)
RUN if [ -f "typo3_src/_.htaccess" ]; then ln -s typo3_src/_.htaccess .htaccess; else cp typo3/sysext/install/Resources/Private/FolderStructureTemplateFiles/root-htaccess .htaccess ; fi

# Configure volumes
VOLUME /var/www/html/fileadmin
VOLUME /var/www/html/typo3conf
VOLUME /var/www/html/typo3temp
VOLUME /var/www/html/uploads
