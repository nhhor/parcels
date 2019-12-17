require('sinatra')
require('sinatra/reloader')
require('./lib/parcel')
require('pry')
also_reload('lib/**/*.rb')

get('/test') do
  @something = "this is a variable"
  erb(:whatever)
end

get('/') do
  @parcels = Parcel.all
  erb(:parcels)
end

get ('/parcels') do
  if params["search"]
    @parcels = Parcel.hunt(params[:search])
  else
    @parcels = Parcel.all
  end
  erb(:parcels)
end
# binding.pry
# puts "LOG SEARCH:" + params["search"]
# puts "LOG SEARCH2:" + params[:search]
#
# puts "LOG parcels:" + @parcels.to_s
# puts "LOG @parcels:" + @parcels.filter { |x| x == params["search"] }
# @parcels = Parcel.all.scan(params["search"].to_i())
# erb(:parcels)

get('/parcels/new') do
  erb(:new_parcel)
end

get('/parcels/:id') do
  @parcel = Parcel.find(params[:id].to_i())
  erb(:parcel)
end

post('/parcels') do
  name = params[:parcel_name]
  parcel = Parcel.new(name, nil)
  parcel.save()
  @parcels = Parcel.all() # Adding this line will fix the error.
  erb(:parcels)
end

get('/parcels/:id/edit') do
  @parcel = Parcel.find(params[:id].to_i())
  erb(:edit_parcel)
end

patch('/parcels/:id') do
  @parcel = Parcel.find(params[:id].to_i())
  @parcel.update(params[:name])
  @parcels = Parcel.all
  erb(:parcels)
end

delete('/parcels/:id') do
  @parcel = Parcel.find(params[:id].to_i())
  @parcel.delete()
  @parcels = Parcel.all
  erb(:parcels)
end

get('/custom_route') do
  "We can even create custom routes, but we should only do this when needed."
end
