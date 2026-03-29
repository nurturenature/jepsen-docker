#!/usr/bin/env bash

# jepsen-control's internal port 8080 is exposed on a dynamic localhost port
PORT=$(docker port jepsen-control 8080 | cut -d : -f 2)

xdg-open "http://localhost:$PORT"
