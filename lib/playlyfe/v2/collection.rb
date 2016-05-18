module Playlyfe
  module V2
    class Collection 
      attr_reader :game
        
      def all
        @items
      end

      def find(str)
        (@items.detect {|item| item.id.include?(str)})
      end  

      def find_all(str_arr)
        coll=[]
        str_arr.each do |str|
          coll << self.find(str)
        end
        coll.compact
      end  

      def first
        @items.first
      end
        
      def last
        @items.last
      end

      def to_a
        @items
      end  

      def size
        @items.size
      end  
      
      private

        #shoudl be redefined in subclasses
        def initialize(game)  
          @game= game
          @items=[]
          fill_items([])
        end
        
        def fill_items(hash_array)  
          hash_array.each do |hash|
            @items << hash
          end  
        end  

         
    end  
  end
end 
