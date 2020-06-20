module HashAccessor
  def hash_accessor(hash_name, *key_names)
    key_names.each do |key_name|
      define_method key_name do
        instance_variable_get("@#{hash_name}")[key_name]
      end
      define_method "#{key_name}=" do |value|
        instance_variable_get("@#{hash_name}")[key_name] = value
      end
    end
  end
end
    
class Foo
  extend HashAccessor
  hash_accessor :bar, :one, :two

  def initialize(bar)
    @bar = bar
  end
end
    
foo = Foo.new(:one => 1, :two => 2) # => #<Foo:0x9c28310
@bar={:one=>1, :two=>2}>
foo.one # => 1
foo.one = 42
foo # => #<Foo:0x9c28310
@bar={:one=>42, :two=>2}>