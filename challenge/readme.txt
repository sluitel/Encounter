Highlight Interview Project:

Please review these instructions carefully:

The file 'userdata.txt' contains a list of geographic points for 4 different
users sorted by the time they were recorded.  The format of each line is 4
fields separated by a pipe character.

name|unixtime|latitude|longitude

example line:
danny|1335324573|37.784372722982|-122.39083248497

Please write a program (any language you choose) that will read the
userdata.txt file and output a list of encounters for the 4 users using
these rules:

* Generate an encounter if the users are <= 150 meters apart.

* If a user has not generated a point for 6 hours, assume they are no longer
  active (don't generate any more encounters until they have a new point)

* Do not generate more than one encounter per 24 hours for any two users (if
  unclejoey and danny had an encounter at 5pm on a Tuesday, they could not
  have another encounter until 5pm on Wednesday)

* Use the Haversine formula for geodesic distance calculation;
  assume the radius of the earth is 6,371,009 meters

The output format should be similar to the input file:

unixtime|name1|latitude1|longitude1|name2|latitude2|longitude2

where name1 is lexigraphically lower than name2 and lines are sorted in
ascending order by unixtime.  The ordering of encounters with the same
unixtime is unspecified.

So if 'danny' and 'unclejoey' encountered each other, it would look like this:

1327418725|danny|37.77695245908|-122.39847741481|unclejoey|37.777335807234|-122.39812024905

The first 20 encounters are provided in 'output_sample.txt' to help verify
syntax and correctness.

There is no time limit for this challenge, but we expect it should take about 3 to
4 hours to complete.

Please send your code and results to me when they're ready!

Checklist:
   * Your source code
   * Build instructions (we reject submissions that do not build)
   * Your program output

We will review your code for organization and clarity as well as technical
correctness.

Thanks,
-Ben @ Highlight
