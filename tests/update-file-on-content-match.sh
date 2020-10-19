#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
run='docker exec -it puppetagent'

function replace-line-when-file-contains-starting-line {
  # given
  echo "
  line 1: one
  line 2: two
  line 3: three
  " > $DIR/../docker/volumes/agent-data/file1.txt


  # when
  sh $DIR/../scripts/run-manifest.sh $DIR/../manifests/update-file-on-content-match.pp

  # then
  if $run cat /agent-data/file1.txt | grep 'replaced line' ; then
      echo "passed!"
  else
      echo "failed!"
      exit 1
  fi
}

function do-nothing-when-file-does-not-exist {
  # given
  rm -rf $DIR/../docker/volumes/agent-data/file1.txt

  # when
  sh $DIR/../scripts/run-manifest.sh $DIR/../manifests/update-file-on-content-match.pp

  # then
  if ! $run test -f /agent-data/file1.txt ; then
      echo "passed!"
  else
      echo "failed!"
      exit 1
  fi
}

# run the tests
replace-line-when-file-contains-starting-line
do-nothing-when-file-does-not-exist