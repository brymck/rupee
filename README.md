Rupee - financial tools for Ruby
================================

<table>
  <tr>
    <td>Homepage</td>
    <td><a href="http://www.brymck.com">www.brymck.com</a></td>
  </tr>
  <tr>
    <td>Author</td>
    <td>Bryan McKelvey</td>
  </tr>
  <tr>
    <td>Copyright</td>
    <td>(c) 2011 Bryan McKelvey</td>
  </tr>
  <tr>
    <td>License</td>
    <td>MIT</td>
  </tr>
</table>

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=brymck&url=https://github.com/brymck/rupee&title=rupee&language=en_GB&tags=github&category=software)

        /|\
       / | \
      /  |  \
     /_ / \ _\    RU       PE      E
    |  |   |  |   _ _      _
    |  |   |  |  | | |    | |__o  ____
    |  |   |  |  | | | _  |  __| |____|
    | _|   |_ |  | | |/ / | |___
     \  \ /  /  /_/|___/   \____|
      \  |  /
       \ | /
        \|/ brymck

Installing
----------

Note that you must have Ruby 1.8.7+ installed and the ability to compile native
extensions (standard on most platforms and available on Windows via
[DevKit](http://rubyinstaller.org/downloads/)).

    gem install rupee

You can also do things the hard way if you want to keep track of the repo:

    git clone git://github.com/brymck/rupee.git
    cd rupee
    bundle update
    rake install

After all that hard work, you can take a test drive by running something like
this in the Ruby console (i.e. `irb` in a command prompt):

    require "rupee"
    Rupee::Option.black_scholes "c", 60, 65, 0.25, 0.08, 0, 0.3

which should return `2.1334`.

You should also be able to get the latest stock info for, for example, Wells
Fargo using the following (note that you only need to `require` the `quote`
module):

    require "rupee/quote"
    Rupee::Quote.bloomberg "WFC", :price, :change, :pct_change

Got it? Good. This will surely help you collect some rupees in real life.

Performance
-----------

This is just a simple benchmark I ran on my own laptop, where I value a simple
call option with Black-Scholes one million times. You can test the same on
yours with rake, but in any case it makes the point that for the mathematical
side of finance a native extension in C/C++ has substantial benefits:

    rake benchmark:black_scholes

Results:

                     user     system      total        real
    rupee:       1.388000   0.000000   1.388000 (  1.440000)
    pure ruby:  18.580000   0.000000  18.580000 ( 18.817000)
