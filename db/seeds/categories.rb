# frozen_string_literal: true

module Seeds
  class Categories < Seeds::Base
    CATEGORIES_COUNT = 3

    def generate!
      Category.import(array_of_attributes(CATEGORIES_COUNT))
    end

    private

    def klass_attributes
      {
        name: FFaker::HipsterIpsum.word
      }
    end
  end
end
