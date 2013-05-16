class Dish < ActiveRecord::Base

    belongs_to :course
    validates_presence_of :title, :summary, :link, :published_at, :post_url
    validates_uniqueness_of :url

end