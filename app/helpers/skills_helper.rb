module SkillsHelper

  def example_skill_slides
    %{<!-- EXAMPLE SLIDES -->

# First Slide
It's number one!
Note: Make lots of funny jokes here, so people like you.

--

## Subslide 1

``` javascript
$('#example').show();
```

--

## Subslide 2
![This is how I explain computer problems to my cat. My cat usually seems happier than me.](http://imgs.xkcd.com/comics/computer_problems.png)

----

# Videos too!

--

## HTML5
<video class="stretch" data-autoplay controls src="http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"></video>

--

## YouTube
<iframe class="stretch" src="//www.youtube.com/embed/YE7VzlLtp-4?enablejsapi=1" frameborder="0" allowfullscreen></iframe>}
  end

end