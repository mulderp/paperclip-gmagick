paperclip-gmagick
=================

Paperclip processor to use GraphicsMagick. GraphicsMagick should be faster than ImageMagick.

Right now only the GraphicsMagick '-resize' option is supported.

Example
=======

    has_attached_file :file,
    :styles => {
      :thumb => "100x100#",
      :tiny => '50x38#'
    }, :path => ":rails_root/public/system/:attachment/:id/:style/:filename", :processors => [:GMagick]

References
===========
* [GraphicsMagick convert command](http://www.graphicsmagick.org/convert.html)

License
=======
MIT, 2013, Patrick Mulder (mulder.patrick@gmail.com)
