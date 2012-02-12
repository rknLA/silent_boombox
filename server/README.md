A very thin skeleton for a basic Sinatra setup:

Install dependencies:

<pre><code>
$ gem install bundler
$ bundle install
</code></pre>

Start the server on port 8080:

`$ unicorn`

Here's the different requests it supports:

`GET /`

... redirects to the `/resource.html` page. Check out `lib/resource.rb` for the source, and `views/resource.erb` for the template.

`GET /resource`

... renders a simple JSON response. Again, see `lib/resource.rb` for info.

Have fun.

