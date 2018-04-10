FROM alpine:3.7
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
			org.label-schema.name="HODLit 3DCoin Miner" \
			org.label-schema.description="Solo CPU mining for 3DCoin" \
			org.label-schema.url="hodlit.io" \
			org.label-schema.vcs-ref=$VCS_REF \
			org.label-schema.vcs-url="https://github.com/HODLit-3dcoin/3dcoin-miner" \
			org.label-schema.vendor="Varts" \
			org.label-schema.version=$VERSION \
			org.label-schema.schema-version="1.0"

RUN set -x && \
addgroup -g 1000 -S crypto && \
adduser -u 1000 -S crypto -G crypto

USER crypto

RUN cd /home/crypto && \
echo '#!/bin/bash' > entrypoint.sh && \
echo '' >> entrypoint.sh && \
echo 'if [[ $# -lt 1 ]] || [[ "$1" == "-"* ]]; then' >> entrypoint.sh && \
	echo 'sleep inf' >> entrypoint.sh && \
echo 'fi' >> entrypoint.sh && \
echo '' >> entrypoint.sh && \
echo 'exec "$@"' >> entrypoint.sh && \
chmod a+x entrypoint.sh

ENTRYPOINT ["/home/crypto/entrypoint.sh"]
