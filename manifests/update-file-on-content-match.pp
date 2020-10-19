node default {
  $new_line = "replaced line"
  $file = "/agent-data/file1.txt"
  exec { "update file if line is present":
    command     => "/bin/sed -i 's/line 1.*/${new_line}/g' ${file}",
    onlyif      => "/bin/test -f ${file} && ! /bin/grep -q ${new_line} ${file}",
  }
}
