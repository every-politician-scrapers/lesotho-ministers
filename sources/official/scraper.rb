#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      tds[2].text.tidy.gsub('Hon. ', '')
    end

    def position
      tds[1].text.tidy
    end

    def empty?
      (tds.count < 3) || name.empty?
    end

    private

    def tds
      noko.css('td')
    end
  end

  class Members
    def member_items
      super.reject(&:empty?)
    end

    def member_container
      noko.xpath('//table[.//td[contains(.,"Finance")]]//tr[td]')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
