class ApplicationController < Sinatra::Base
  # setup default content type to application/json
  set :default_content_type, 'application/json'

  # add routes
  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(include: :baked_goods)
  end

  get '/baked_goods/by_price' do
    # baked_goods = BakedGood.all.order(price: :desc)
    baked_goods = BakedGood.all.sort_by { |baked_good| -baked_good[:price]}
    baked_goods.to_json
  end

  get '/baked_goods/most_expensive' do
    # baked_good = BakedGood.all.order(price: :desc).first
    baked_good = BakedGood.all.max_by { |baked_good| baked_good[:price]}
    baked_good.to_json
  end

end
