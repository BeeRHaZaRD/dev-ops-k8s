FROM python:3.10-alpine

ARG USER=app 
ARG UID=1001
ARG GID=1001

RUN addgroup -g ${GID} -S ${USER} \
   && adduser -u ${UID} -S ${USER} -G ${USER} \
   && mkdir -p /app \
   && chown -R ${USER}:${USER} /app
USER ${USER}

WORKDIR /app

COPY --chown=$USER:$USER static/ /app

EXPOSE 8000

CMD ["python", "-m", "http.server", "8000"]
