---
layout: post
title:  "Highlight Text in Bash"
date:   2016-02-05 21:07:54
categories: [linux, bash]
tags: [bash, linux, grep]
---

We want to highlight like grep, but we do not want to filter out unmatched lines. Very nice for `tail`ing logs! We what something like this:

![bash text highligt]({{ site.base-url }}/assets/images/posts/2016-02-05/Screen Shot.png)

### The quick and the dirty...

Use `grep` to match the start of every line (`^`) or "some" text. `B` in this case.

{% highlight bash %}
% printf "A\nB\nB\nC\n" | grep --color=always -E "^|B"
A
B
B
C
{% endhighlight %}

### Adding in colors

Yellow! Set the grep highlight color using the `GREP_COLORS` environment variable.

{% highlight bash %}
% printf "A\nB\nB\nC\n" | env GREP_COLORS="ms=1;33" grep --color=always -E "^|B"
A
B
B
C
{% endhighlight %}

### Stacking greps

When `grep`ing another `grep` output. To stop grep buffering in a pipe, add the `--line-buffered` option.

{% highlight bash %}
% printf "A\nB\nB\nC\n" | env GREP_COLORS="ms=1;33" grep --color=always -E "^|B" |env GREP_COLORS="ms=1;34" grep --color=always -E "^|A"
A
B
B
C
{% endhighlight %}


### Putting it all together

To produce the screenshot at the top of the page we can roll this into a nice bash script with cli args and color names :bowtie:. Here is the usage output:

{% highlight console %}
usage: /usr/local/bin/highlight [-c <color>] regex
  options:
    -c color    Color to highlight regex matches with

Valid colors: black,blue,green,cyan,red,purple,brown,lightgray,darkgray,lightblue,lightgreen,lightcyan,lightred,lightpurple,yellow,white
{% endhighlight %}

And the full script [here](https://gist.github.com/shanegibbs/e98efe6178ac5c25d69a).

{% gist e98efe6178ac5c25d69a %}
