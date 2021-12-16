# How to build this image

```bash
docker build -t local/bug-telegraf .
```

# Test the error

First build the image.

Then, run it and wait for it to finish. You'll see the error immediately.

```bash
$ docker run --rm -it local/bug-telegraf
2021-12-16T10:11:13Z I! Starting Telegraf 1.21.0
2021-12-16T10:11:13Z I! Loaded inputs: tail
2021-12-16T10:11:13Z I! Loaded aggregators:
2021-12-16T10:11:13Z I! Loaded processors:
2021-12-16T10:11:13Z I! W! Outputs are not used in testing mode!
2021-12-16T10:11:13Z I! Tags enabled: host=30c097b3ff33
2021-12-16T10:11:13Z D! [agent] Initializing plugins
2021-12-16T10:11:13Z D! [agent] Starting service inputs
2021-12-16T10:11:13Z D! [inputs.tail] Tail added for "/usr/local/cpanel/logs/spamd_error_log"
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x20 pc=0x7c8b5f]

goroutine 72 [running]:
github.com/influxdata/telegraf/plugins/parsers/grok.(*Parser).ParseLine(0xc0004821e0, {0xc0000bcee0, 0x68})
    /go/src/github.com/influxdata/telegraf/plugins/parsers/grok/parser.go:213 +0x2ff
github.com/influxdata/telegraf/plugins/parsers/grok.(*Parser).Parse(0x44ab40, {0xc0000bce70, 0x68, 0x70})
    /go/src/github.com/influxdata/telegraf/plugins/parsers/grok/parser.go:386 +0x15c
github.com/influxdata/telegraf/plugins/inputs/tail.parseLine({0x577f6b0, 0xc0004821e0}, {0xc0000bd1f0, 0x0})
    /go/src/github.com/influxdata/telegraf/plugins/inputs/tail/tail.go:303 +0x10f
github.com/influxdata/telegraf/plugins/inputs/tail.(*Tail).receiver(0xc0001af600, {0x577f6b0, 0xc0004821e0}, 0xc0007266e0)
    /go/src/github.com/influxdata/telegraf/plugins/inputs/tail/tail.go:371 +0x4f4
github.com/influxdata/telegraf/plugins/inputs/tail.(*Tail).tailNewFiles.func2()
    /go/src/github.com/influxdata/telegraf/plugins/inputs/tail/tail.go:275 +0x85
created by github.com/influxdata/telegraf/plugins/inputs/tail.(*Tail).tailNewFiles
    /go/src/github.com/influxdata/telegraf/plugins/inputs/tail/tail.go:273 +0x7af
```

# How to diagnose the container

If you need to drop to a container inside the shell you can:

```bash
# As "telegraf" user
docker run -it --rm --entrypoint bash local/bug-telegraf

# As "root" user
docker run -it --rm --entrypoint bash -u root local/bug-telegraf
```
