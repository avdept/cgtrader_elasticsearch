require 'json'
require 'net/http'

class ImportData

  URL = 'https://datasets-server.huggingface.co/rows'

  def json
    puts 'Reading json'
    file = File.read('db/data.json')
    json = JSON.parse(file)
    puts 'Finished reading json'
    insert(json['Prompt'])
    puts 'Done'
  end

  def network
    offset = 0
    loop do

      uri = URI("#{URL}?offset=#{offset}&length=100&split=train&config=default&dataset=Gustavosta%2FStable-Diffusion-Prompts")
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)
      if data['rows'].nil?
        sleep(rand(3)) # Sleep for a random amount of time because of rate limiting from Hugging Face
        next
      end

      break if data['rows'].empty?

      insert(data['rows'].map { |item| item['row']['Prompt'] })
      offset += 100
      printf("\rImported: #{offset - 100} of #{data['num_rows_total']}")
    end
    puts 'Done'
  end

  private

  def insert(prompts)
    puts 'Importing postgres data'
    SearchItem.import [:description], prompts.map { |prompt| [prompt] }
    puts 'Finished importing postgres data'
    puts 'Importing elasticsearch data'
    client = Elasticsearch::Client.new

    body = ''
    SearchItem.find_each do |item|
      body << { index: { _index: 'search_items', _type: '_doc', _id: item.id } }.to_json + "\n"
      body << { description: item.description }.to_json + "\n"
    end
    client.bulk(body: body)

    puts 'Done'
  end
end
