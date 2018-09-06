#!/usr/bin/env bash

# 쉬고 있는 profile 찾기: set1이 사용중이면 set2가 쉬고 있고, 반대면 set1이 쉬고 있음
function find_idle_profile()
{
    response_code=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/profile)

    if [ ${response_code} -ge 400 ]
    then
        current_profile=set2
    else
        current_profile=$(curl -s http://localhost/profile)
    fi

    if [ ${current_profile} == set1 ]
    then
      idle_profile=set2
    elif [ ${current_profile} == set2 ]
    then
      idle_profile=set1
    else
      idle_profile=set1
    fi

    echo "${idle_profile}"
}

# 쉬고 있는 profile의 port 찾기
function find_idle_port()
{
    idle_profile=$(find_idle_profile)

    if [ ${idle_profile} == set1 ]
    then
      echo "8080"
    else
      echo "8081"
    fi
}