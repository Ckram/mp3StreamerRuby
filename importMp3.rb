#!/usr/bin/env ruby
require 'taglib'
require 'stretcher'



def print_file_information(fileName)
  #puts "Got #{x}"
  TagLib::FileRef.open(fileName) do |fileref|
   unless fileref.null?
    tag = fileref.tag
    puts(tag.title)   #=> "Wake Up"
    puts(tag.artist)  #=> "Arcade Fire"
    puts(tag.album)   #=> "Funeral"
    puts(tag.year)    #=> 2004
    puts(tag.track)   #=> 7
    puts(tag.genre)   #=> "Indie Rock"

    properties = fileref.audio_properties
    puts(properties.length)  #=> 335 (song length in seconds)
   end
  end
 end

d = Dir.glob("/home/ckram/Documents/Musique/**/*.mp3")

d.each  do |fileName|
  print_file_information(fileName)
end  # File is auto

# Connect to elasticsearch
es = Stretcher::Server.new('http://localhost:9200')

# Delete the tracks index if it exists
es.index(:tracks).delete if es.index(:tracks).exists?

# Bulk index the tweet documents
es.index(:tracks).bulk_index [].tap { |docs|
  puts(es)
}
