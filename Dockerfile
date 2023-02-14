FROM alpine:3.17

ENV NAME=experiment_runner VERSION=0 ARCH=x86_64

LABEL org.label-schema="$NAME" \
     name="$FGC/$NAME" \
     version="$VERSION" \
     architecture="$ARCH" \
     run="podman run -it IMAGE" \
     maintainer="Iztok Fister, Jr. <iztok@iztok-jr-fister.eu>" \
     url="https://github.com/firefly-cpp/experiment-runner-container" \
     summary="A basic container image for data science reproducibility based on experiment_runner." \
     description="A basic container image for data science reproducibility based on experiment_runner."

WORKDIR /var/ds/

ENV PACKAGES="\
    py3-niapy \
    py3-niaarm \
    git \
    elixir \
"

RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk update \
    && apk upgrade && apk add --no-cache \
    python3 \
    python3-dev \
    py3-pip \
    $PACKAGES \
    && rm -rf /var/cache/apk/*

COPY niaexp .

RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && mix run -e "IO.puts(Niaexp.start())" \

# open the shell to explore the results in the export folder
#CMD ["/bin/sh"]
