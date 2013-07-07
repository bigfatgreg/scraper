require 'hpricot'
require 'open-uri'

module Scraper
  class Blog
        
    attr_reader :url
    
    def initialize url 
      @url = url
    end

    def parse content
      doc = get content    
      { 
        :title => doc.at('title').inner_html.strip,
        :links => doc.search("/html/body//a").map { |e| e[:href] },
        :mp3s => doc.search("/html/body//a").map { |e| e[:href] }.compact.keep_if { |l| l.match(/mp3$/) },
        :images => doc.search("/html/body//img").map { |e| e[:src] }.compact
      }
    end

    private
    
    def get url
      open(url) { |f| Hpricot(f) } 
    end
     
  end
end