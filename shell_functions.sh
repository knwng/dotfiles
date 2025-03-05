#!/bin/bash

function enterc() {
    docker exec -it $1 /bin/bash
}
export enterc

