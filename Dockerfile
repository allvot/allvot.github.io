FROM ruby:3.2.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .
COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

RUN echo 'PS1="\[\e[38;5;17m\]Alvaro.ai\[\e[m\]\[\e[38;5;15m\] : \[\e[m\]\[\e[38;5;250m\]\w\[\e[m\]\[\e[38;5;231m\] λ \[\e[m\]"' >> ~/.bashrc

ENTRYPOINT ["./entrypoint.sh"]