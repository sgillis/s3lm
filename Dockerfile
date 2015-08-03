FROM sgillis/elm

RUN apt-get update && apt-get install -y git
RUN mkdir -p /s3lm
WORKDIR /s3lm
