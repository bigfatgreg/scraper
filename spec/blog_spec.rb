require_relative '../blog.rb'

describe Scraper::Blog do

  let (:url) { File.join('spec', 'fixtures', 'jfg.html') }
  # let (:url) { "http://www.bumrocks.com" }
  let (:scraper) { Scraper::Blog.new(url) }

  describe "#initialize" do
    
    it "stores a url" do
      expect(scraper.url).to eq url
    end

  end

  describe "#parse" do
    
    let (:html) { File.join('spec', 'fixtures', 'jfg.html') }
    let (:content) { scraper.parse html }
  
    it "extracts all links" do
      expect(content[:links].first).to eq "http://www.20jazzfunkgreats.co.uk/wordpress"
    end

    it "makes an array of mp3 links" do
      expect(content[:mp3s].keep_if { |l| !l.match(/mp3$/) }).to be_empty
    end

    it "makes an array of image links" do
      expect(content[:images].keep_if { |l| !l.match(/(jpg$|png$|gif$)/) }).to be_empty
    end
    
    it "extracts the page's title" do
      expect(content[:title]).to eq "20jazzfunkgreats | mp3 blog fanzine from brighton uk"
    end
  
  end

end