module Austere
  class Path
    def initialize(path)
      @path = path
    end

    def to_s
      @path
    end

    def split
      @split ||= begin
        s = @path.split("/")
        s[-1] = s[-1].split(".").first if format
        s
      end
    end

    def parameters
      @parameters ||= split.map do |component|
        component[1..-1] if component[0] == ":"
      end.compact
    end

    def format
      index = @path.rindex(".")
      index ? @path[index+1..-1] : nil
    end

    def ==(other)
      other_path = self.class.new(other)
      other_path_split = other_path.split

      return false if split.length != other_path_split.length
      return false if format != other_path.format

      split.each_with_index do |component, i|
        return false if component[0] != ":" && component != other_path_split[i]
      end

      true
    end
  end
end
