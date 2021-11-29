#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      Name.new(
        full: noko.css('.name').text.tidy,
        prefixes: %w[The Right Honourable],
      ).short
    end

    def position
      noko.css('.designation').text.tidy
    end
  end

  class Members
    def member_items
      super.reject { |row| row.name.empty? }
    end

    def member_container
      noko.css('.tlp-content')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
