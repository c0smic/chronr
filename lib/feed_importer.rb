require 'feedzirra'

class FeedImporter
    def self.import_railscasts
        # because the Railscasts feed is targeted at itunes, there is additional metadata that
        # is not collected by Feedzirra by default. By using add_common_feed_entry_element,
        # we can let Feedzirra know how to map those values. See more information at
        # http://www.ruby-doc.org/gems/docs/f/feedzirra-0.1.2/Feedzirra/Feed.html
        Feedzirra::Feed.add_common_feed_entry_element(:enclosure, :value => :url, :as => :post_url)

        # Capture the feed and iterate over each entry
        feed = Feedzirra::Feed.fetch_and_parse("http://xkcd.com/rss.xml")
        feed.entries.each do |entry|

          # Find or create the screencast data into our database
          Screencast.where(post_url: entry.post_url).first_or_create(
            title:        entry.title,
            summary:      entry.summary
            link:         entry.url,
            published_at: entry.published
          )
        end

        # Return the number of total screencasts for the source
        Screencast.where(source: 'railscasts').count
    end
end