#!/usr/bin/env ruby
require 'taglib'
require 'elasticsearch'

def save_file_information(fileName, client, i)
  #puts "Got #{x}"
  TagLib::FileRef.open(fileName) do |fileref|
   unless fileref.null?

    tag = fileref.tag
    # puts(tag.title)   #=> "Wake Up"
    # puts(tag.artist)  #=> "Arcade Fire"
    # puts(tag.album)   #=> "Funeral"
    # puts(tag.year)    #=> 2004
    # puts(tag.track)   #=> 7
    # puts(tag.genre)   #=> "Indie Rock"
    properties = fileref.audio_properties

    client.index  index: 'tracks', type: 'track', id: i, body: { title: tag.title, artist:tag.artist, album:tag.album,
       year: tag.year, trackNumber: tag.track, genre: tag.genre, length:properties.length }
   end
  end
 end

client = Elasticsearch::Client.new log: true

 #client.transport.reload_connections!

client.cluster.health

client.index  index: 'tracks', type: 'track', id: "test", body: { title: "test" }




d = Dir.glob("/home/ckram/Documents/Musique/**/*.mp3")
i=0

 d.each  do |fileName|
  save_file_information(fileName,client,i)

  i = i + 1
 end

client.search q: '*'
