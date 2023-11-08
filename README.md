# CGTrader Search Assignment

## Preview
![pika-1699473146614-1x](https://github.com/avdept/cgtrader_elasticsearch/assets/1757017/74615bf7-5be0-4b15-8003-5f799be8ce32)



## Description
This is simple search app using ruby on rails, postgres and elasticsearch made for CGTrader assignment. For initial dataset I've used following dataset `https://huggingface.co/datasets/Gustavosta/Stable-Diffusion-Prompts`. In order to pull the data into database I've created simple script which can be invoked by simply running `bundle exec rake db:seed` or manually invoking `ImportData.new.call` from rails console.

## Installation & Usage

#### Manual

* `bundle install`
* Change `database.yml` if you have non standard config
* `bundle exec rake db:create db:migrate db:seed` to fill database with prompts from `db/data.json` file
* Make sure you have `elasticsearch` running on port `9200`
* Run `bin/dev` to start server
* Open `http://localhost:3005` in your browser and try to search for some words


#### Docker

* Simply run `docker-compose up` and give it a time to boot up. Please note first launch might take some time, up to 1-2 mins depending on computer specs, because it imports data
* Open `http://localhost:3005` in your browser and try to search for some words

## Future improvements

* TO refine search results - I'd introduce some fixed value list with tags, such as medieval, object, nature, which could act as a filtering option to get more correct results
* Usage of synonyms. If its 3d objects marketplace usually user searches for specific object like `sword` or `car`. In order to provide more results - we could use some small LLM to get list of synonyms for specific query(and cache it to reduce time lag for user), so that for query `sword` we could get query like `weapon, medieval weapon, sword, blade, dagger, knife`
* If user registred, we could use his previous search history and visited items, to better understand what kind of items user looks like.


## Notes
* I did not implement pagination, since this is out of context of this assignment
* I did not deploy code to heroku, since their free tier elasticsearch provides only up to 35k documents. Others are paid options. If you'll want to test my devops skills - I can create digital ocean instance for this app and deploy it manually.
