class SearchItem < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.search(query)
    __elasticsearch__.search({
      query: {
        multi_match: {
          query: query,
          fields: ['description'],
          fuzziness: 'AUTO'
        }
      },
      size: 100,
      sort: [
        { "_score": { "order": "desc" } }
      ]
    })
  end
end
