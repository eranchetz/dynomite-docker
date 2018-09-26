#!/bin/bash

redis-server --port 8889 &


sleep 3

src/dynomite --conf-file=conf/configuration-file.yaml -v11
