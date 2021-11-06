DOCKER_REGISTY=lostos/spritsail-plex-media-server
ARGS=$(curl -s https://raw.githubusercontent.com/spritsail/plex-media-server/master/Dockerfile | grep ARG)
PLEX_VER=$(echo "$ARGS" | grep "PLEX_VER=" | cut -d '=' -f 2)
echo PLEX_VER=$PLEX_VER
BUSYBOX_VER=$(echo "$ARGS" | grep "BUSYBOX_VER=" | cut -d '=' -f 2)
echo BUSYBOX_VER=$BUSYBOX_VER
SU_EXEC_VER=$(echo "$ARGS" | grep "SU_EXEC_VER=" | cut -d '=' -f 2)
echo SU_EXEC_VER=$SU_EXEC_VER
TINI_VER=$(echo "$ARGS" | grep "TINI_VER=" | cut -d '=' -f 2)
echo TINI_VER=$TINI_VER
ZLIB_VER=$(echo "$ARGS" | grep "ZLIB_VER=" | cut -d '=' -f 2)
echo ZLIB_VER=$ZLIB_VER
LIBXML2_VER=$(echo "$ARGS" | grep "LIBXML2_VER=" | cut -d '=' -f 2)
echo LIBXML2_VER=$LIBXML2_VER
LIBXSLT_VER=$(echo "$ARGS" | grep "LIBXSLT_VER=" | cut -d '=' -f 2)
echo LIBXSLT_VER=$LIBXSLT_VER
XMLSTAR_VER=$(echo "$ARGS" | grep "XMLSTAR_VER=" | cut -d '=' -f 2)
echo XMLSTAR_VER=$XMLSTAR_VER
OPENSSL_VER=$(echo "$ARGS" | grep "OPENSSL_VER=" | cut -d '=' -f 2)
echo OPENSSL_VER=$OPENSSL_VER
CURL_VER=$(echo "$ARGS" | grep "CURL_VER=" | cut -d '=' -f 2)
echo CURL_VER=$CURL_VER

echo "check update..."
if [ "" != "$(curl -s https://registry.hub.docker.com/v1/repositories/$DOCKER_REGISTY/tags | grep \\\"$PLEX_VER\\\")" ]; then
  echo "no update."
  exit
fi

docker buildx build \
  --push \
  --build-arg PLEX_VER=$PLEX_VER \
  --build-arg BUSYBOX_VER=$BUSYBOX_VER \
  --build-arg SU_EXEC_VER=$SU_EXEC_VER \
  --build-arg TINI_VER=$TINI_VER \
  --build-arg ZLIB_VER=$ZLIB_VER \
  --build-arg LIBXML2_VER=$LIBXML2_VER \
  --build-arg LIBXSLT_VER=$LIBXSLT_VER \
  --build-arg XMLSTAR_VER=$XMLSTAR_VER \
  --build-arg OPENSSL_VER=$OPENSSL_VER \
  --build-arg CURL_VER=$CURL_VER \
  --tag $DOCKER_REGISTY:latest \
  --tag $DOCKER_REGISTY:$PLEX_VER \
  .
docker image prune -f
