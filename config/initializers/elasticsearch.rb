require 'elasticsearch/model'
Elasticsearch::Model.client = Elasticsearch::Client.new host: ENV.fetch('ELASTICSEARCH_URL', 'localhost:9200')
