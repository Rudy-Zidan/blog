FROM ruby:3.1.2-bullseye

WORKDIR /blog/api

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential

COPY . .

RUN bundle install --jobs 20 --retry 5

# Puma
EXPOSE 3000

CMD ["./docker/entry_point.sh"]
