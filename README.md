fitbit-weight-importer
========================

Requirements
------------------------

* Ruby 1.8.7+
* Bundler 1.3.4+

Setup
------------------------

### Local

    $ bundle install --path .bundle

### Fitbit

1. Access to https://dev.fitbit.com/apps/new
2. Get your consumer / consumer secret
3. Write your consumer / consumer secret to config/fitbit.yml

CSV Format
------------------------
For example:

    "Date","Weight","Fat"
    "2012-12-09","56.30","17.00"
    "2012-09-09","54.80","16.90"

Run
------------------------

    $ bundle exec ruby bin/main.rb graph.csv

License
------------------------

The MIT License (MIT)
Copyright (c) 2013 mallowlabs

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


