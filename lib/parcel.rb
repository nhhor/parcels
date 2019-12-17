class Parcel
  attr_reader :id, :name #Our new save method will need reader methods.
  @@parcels = {}
  @@total_rows = 0 # We've added a class variable to keep track of total rows and increment the value when an parcel is added.

  def initialize(name, id) # We've added id as a second parameter.
    @name = name
    @id = id || @@total_rows += 1  # We've added code to handle the id.
  end

  def self.all
    @@parcels.values()
  end

  def self.hunt(x)
    @@parcels.values().select {|e| /#{x}/i.match? e.name}
  end

  def save
    @@parcels[self.id] = Parcel.new(self.name, self.id)
  end

  def ==(parcel_to_compare)
    self.name() == parcel_to_compare.name()
  end
  def self.clear
    @@parcels = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@parcels[id]
  end

  def update(name)
    @name = name
  end

  def delete
    @@parcels.delete(self.id)
  end

end
