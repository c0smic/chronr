class Course < ActiveRecord::Base

    has_many :dishes
    validates_presence_of :title, :summary

end