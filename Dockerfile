# syntax=docker/dockerfile:1

FROM debian:buster-slim

RUN yes | head -20 | tee /yes.txt
COPY . /app
