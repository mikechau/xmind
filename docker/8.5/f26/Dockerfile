FROM fedora:26

ENV XMIND_VERSION=8.5 \
    XMIND_DOWNLOAD_URL=http://dl2.xmind.net/xmind-downloads/xmind-8-update5-linux.zip \
    GOSU_GPG_KEY=B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    GOSU_VERSION=1.10 \
    BUILD_DIR=/build \
    DIST_DIR=/build/RPMs/x86_64

WORKDIR "${BUILD_DIR}"

RUN set -xe \
  && dnf -y update \
  && dnf -y install \
    gpg \
    dpkg \
    rpmdevtools \
    wget \
  && dnf clean all \
  && mkdir -p ${DIST_DIR} \
  && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "${GOSU_GPG_KEY}" \
  && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture)" \
  && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc" \
  && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu \
  && chmod 777 ${BUILD_DIR}

COPY ["basic-checks.sh", "common-functions.sh", "create-package.sh", "start-xmind.sh", "terminal-colors.sh", "xmind-256.png", "xmind-64.png", "xmind.desktop", "xmind.spec", "xmind.xml", "./"]
COPY docker/scripts/entrypoint.sh /usr/local/bin/entrypoint.sh

RUN chmod +x "${BUILD_DIR}/basic-checks.sh" \
  && chmod +x "${BUILD_DIR}/common-functions.sh" \
  && chmod +x "${BUILD_DIR}/create-package.sh" \
  && chmod +x "${BUILD_DIR}/start-xmind.sh" \
  && chmod +x "${BUILD_DIR}/terminal-colors.sh" \
  && chmod +x /usr/local/bin/entrypoint.sh

VOLUME "${DIST_DIR}"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["./create-package.sh"]
