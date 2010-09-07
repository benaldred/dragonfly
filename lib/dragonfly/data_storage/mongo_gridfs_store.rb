require 'mongo_mapper'

module Dragonfly
  module DataStorage

    class MongoGridfsStore < Base
      
      include Configurable
      
      configurable_attr :grid_fs_database
      
      def store(temp_object)

        db = Mongo::Connection.new.db('grid_fs_database')
        grid = Mongo::Grid.new(db)

        # returns object id
        id = grid.put(File.read(temp_object.path), 'beach.png')
        id
      end

      def retrieve(uid)
        db = Mongo::Connection.new.db('grid_fs_database')
        grid = Mongo::Grid.new(db)
        file = grid.get(ObjectID.from_string(uid))
        file.read
      end
      
      def destroy(uid)
        db = Mongo::Connection.new.db('grid_fs_database')
        grid = Mongo::Grid.new(db)
        grid.delete(ObjectID.from_string(uid))
      end
    end
  end
end