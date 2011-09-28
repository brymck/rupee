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
    Rupee::Call.new(
      :underlying => 60,
      :strike     => 65,
      :time       =>  0.25,
      :rate       =>  0.08,
      :div_yield  =>  0.00,
      :volatility =>  0.3
    ).black_scholes

both of which should return `2.1334`.

You should also be able to get the latest stock info for, for example, Wells
Fargo using the following (note that you only need to `require` the `quote`
module):

    require "rupee/quote"
    wfc = Rupee::Quote.new("WFC")

    wfc.get :price, :change, :pct_change
    #=> {:price=>24.96, :change=>0.17, :pct_change =>0.686}

    wfc.price
    #=> 24.96

    wfc.change
    #=> 0.17

`wfc.get` will return a hash of the requested information for the security.
Each valid parameter will also have its own utility method. The results will
update every `wfc.frequency` seconds (defaults to 15).

Got it? Good. This will surely help you collect some rupees in real life.

Performance
-----------

This is just a simple benchmark I ran on my own laptop, where I value a simple
call option with Black-Scholes 100,000 times. You can test the same on yours
with rake, but in any case it makes the point that for the mathematical side
of finance a native extension has substantial benefits:

    rake benchmark:black_scholes

Results:

                              user     system      total        real
    Rupee (class):        0.190000   0.000000   0.190000 (  0.194001)
    Rupee (one object):   0.180000   0.000000   0.180000 (  0.183091)
    Rupee (new object):   2.210000   0.000000   2.210000 (  2.213351)
    Pure Ruby:            2.320000   0.000000   2.320000 (  2.324259)

In words, for math-intensive operations, using a C implementation is clearly
faster than the same thing in Ruby.

Also, if you're doing a valuation on a one-off set of examples (e.g. in a Monte
Carlo simulation), you probably don't want to create an object every time.
Something like `Rupee::Option.black_scholes ...` should work just fine.
Creating a `Rupee::Option` object takes roughly the same amount of time as
running `Rupee::Option.black_scholes` a dozen times.

However, if you're creating and reusing an object, I strongly recommend
preserving the object orientation of Ruby: the penalty for using a new instance
rather than calling the class method directly is almost entirely in the object
initialization itself.
