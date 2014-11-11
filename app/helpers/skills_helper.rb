module SkillsHelper

  def example_skill_slides
    "/ EXAMPLE SLIDES\nsection\n\n  section\n    h1 First Slide\n    p It's number one!\n    aside.notes Make lots of funny jokes here, so people like you.\n\n  section\n    h2 Subslide 1\n    pre\n      code(data-trim)\n        | $('#example').show();\n\n  section\n    h2 Subslide 2\n    img.full(src='http://imgs.xkcd.com/comics/computer_problems.png')\n\nsection\n\n  section\n    h1 Second Slide\n    video(data-autoplay controls src='http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4')"
  end

end