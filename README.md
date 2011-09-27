rupee
=====

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=brymck&url=https://github.com/brymck/rupee&title=rupee&language=en_GB&tags=github&category=software)

        /|\
       / | \
      /  |  \
     /_ / \ _\  
    |  |   |  |   _ _      _
    |  |   |  |  | | |    | |__o  ____
    |  |   |  |  | | | _  |  __| |____|
    | _|   |_ |  | | |/ / | |___
     \  \ /  /  /_/|___/   \____|
      \  |  /
       \ | /
        \|/ brymck

==== Benchmarking

This is just a simple benchmark I ran on my own laptop, where I value a simple
call option with Black-Scholes one million times. You can test the same on
yours with rake, but in any case it makes the point that for the mathematical
side of finance a native extension in C/C++ has substantial benefits:

    rake benchmark:black_scholes

Results:

<table>
  <thead>
    <tr>
      <th>Implementation</th>
      <th>Seconds elapsed</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><a href="http://www.espenhaug.com/black_scholes.html">Pure Ruby</a></td>
      <td>19.047</td>
    </tr>
    <tr>
      <td>Rupee (Ruby + C)</td>
      <td>1.451</td>
    </tr>
  </tbody>
</table>
