# LogParser

Ruby script for parsing log files.

## Installation

Just run:
```ruby
$ bundle exec bin/setup
```
## Usage

Return webpages with views count, ordered descending.

```ruby
$ ./bin/parse file_path webserver.log
```

Return webpages with unique views count, ordered descending.

```ruby
$ ./bin/parse file_path webserver.log -u [--unique]
```
