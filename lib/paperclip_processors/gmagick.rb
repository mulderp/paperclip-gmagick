module Paperclip
  class GMagick

    attr_accessor :source_file_options, :convert_options

    def initialize(file, options = {}, attachment = nil)
      @geometry            = options[:geometry]
      @file                = file
      @format              = options[:format]
      @current_format      = File.extname(@file.path)
      @basename            = File.basename(@file.path, @current_format)

      @target_geometry     = (options[:string_geometry_parser] || Geometry).parse(@geometry)
      @current_geometry    = (options[:file_geometry_parser] || Geometry).from_file(@file)
    end

    def self.make(file, options = {}, attachment = nil)
      new(file, options, attachment).make
    end

    def make
      src = @file
      dst = Tempfile.new([@basename, @format ? ".#{@format}" : ''])

      begin
        parameters = []
        parameters << source_file_options
        parameters << ":source"
        parameters << transformation_command
        parameters << convert_options
        parameters << ":dest"

        parameters = parameters.flatten.compact.join(" ").strip.squeeze(" ")

        success = convert(parameters, :source => "#{File.expand_path(src.path)}#{'[0]'}", :dest => File.expand_path(dst.path))
      rescue Cocaine::ExitStatusError => e
        raise Paperclip::Error, "There was an error processing the thumbnail for #{@basename}" if @whiny
      rescue Cocaine::CommandNotFoundError => e
        raise Paperclip::Errors::CommandNotFoundError.new("Could not run the `gm convert` command. Please install GraphicsMagick.")
      end

      dst
    end
    
    def convert(arguments = "", local_options = {})
      Paperclip.run('gm convert', arguments, local_options)
    end

    def identify(arguments = "", local_options = {})
      Paperclip.run('gm identify', arguments, local_options)
    end

    # Returns the command ImageMagick's +convert+ needs to transform the image
    # into the thumbnail.
    def transformation_command
      scale = transformation_to(@geometry)
      trans = []
      #trans << "-auto-orient" if auto_orient
      trans << "-resize" << %["#{scale}"] unless scale.nil? || scale.empty?
      #trans << "-crop" << %["#{crop}"] << "+repage" if crop
      trans
    end

    def crop?
      @crop
    end

    def transformation_to(geometry)
      geometry.gsub("#","")
    end

    # Returns true if the image is meant to make use of additional convert options.
    def convert_options?
      !@convert_options.nil? && !@convert_options.empty?
    end

  end

end
