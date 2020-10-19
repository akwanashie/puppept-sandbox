#! /usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
run='docker exec -it puppetagent'
source $DIR/../scripts/process-output.sh

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
  if $run cat /agent-data/file1.txt | grep -q 'replaced line' ; then
      echo "${FUNCNAME[0]} - passed!"
  else
      echo "${FUNCNAME[0]} - failed!"
      exit 1
  fi

  # cleanup
  rm -rf $DIR/../docker/volumes/agent-data/output.json
}

function do-nothing-when-file-does-not-exist {
  # given
  rm -rf $DIR/../docker/volumes/agent-data/file1.txt

  # when
  sh $DIR/../scripts/run-manifest.sh $DIR/../manifests/update-file-on-content-match.pp

  # then
  if ! $run test -f /agent-data/file1.txt ; then
      echo "${FUNCNAME[0]} - passed!"
  else
      echo "${FUNCNAME[0]} - failed!"
      exit 1
  fi

  # cleanup
  rm -rf $DIR/../docker/volumes/agent-data/output.json
}

function do-nothing-when-file-already-contains-replacement-line {
  # given
  echo "
  line 1: one
  replaced line
  line 3: three
  " > $DIR/../docker/volumes/agent-data/file1.txt

  # when
  sh $DIR/../scripts/run-manifest.sh $DIR/../manifests/update-file-on-content-match.pp

  # then
  NOTICE_COUNT=$((count-sucessful-notices))

  if [[ $NOTICE_COUNT -eq 0 ]]; then
    echo "${FUNCNAME[0]} - passed!"
    # cleanup
    rm -rf $DIR/../docker/volumes/agent-data/output.json
  else
    echo "${FUNCNAME[0]} - failed!"
    # cleanup
    rm -rf $DIR/../docker/volumes/agent-data/output.json
    exit 1
  fi
}

# run the tests
replace-line-when-file-contains-starting-line
do-nothing-when-file-does-not-exist
do-nothing-when-file-already-contains-replacement-line