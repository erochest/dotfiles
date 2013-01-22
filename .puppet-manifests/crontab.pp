
cron { janitor :
  command => '~err8n/bin/janitor.py',
  user    => err8n,
  hour    => 10,
  minute  => 0,
  weekday => 'mon',
}

