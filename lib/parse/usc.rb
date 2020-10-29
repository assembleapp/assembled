require "nokogiri"

module Parse
    LEVELS = %w[
        preliminary
        title
        subtitle
        chapter
        subchapter
        part
        subpart
        division
        subdivision
        article
        subarticle
        section
        subsection
        paragraph
        subparagraph
        clause
        subclause
        item
        subitem
        subsubitem
    ]

    HEADINGS = ["document", "uscDoc", "main"]

    class USC
        def initialize(path)
            @sources = Dir.glob(File.join(path, "/*.xml")).sort
        end

        attr_accessor :sources

        def parse
            debug = true
            sources.map do |s|
                puts s
                xml = Nokogiri::XML(File.read(s))
                response = []
                xml.traverse do |x|
                    if ([x.name] + x.ancestors.map(&:name)).all? {|n| (HEADINGS + LEVELS).include? n }
                        body = x.search("content")[0].text rescue x.text
                        checksum = Digest::SHA2.hexdigest(body)
                        Measure.create!(
                            name: x.name,
                            key: x.attr("identifier"),
                            checksum: checksum,
                            body: body,
                            label: (x.search("num")[0].attr("value") rescue nil),
                            heading: (x.search("heading")[0].text rescue nil),
                        )
                        unless HEADINGS.include? x.name
                            x.replace("{measure '#{checksum}'}")
                        end
                    end
                end
                response
            end
        end

        def load
        end
    end
end

def go
    Parse::USC.new("./source").parse
end