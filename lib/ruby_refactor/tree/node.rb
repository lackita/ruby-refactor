require "range"
require "unparser"
require "ruby_refactor/tree/searchable"

class RubyRefactor
  class Tree
    class Node
      include Searchable
      attr_reader :type, :children, :value, :lines, :original_ast, :location
      attr_accessor :comments

      def initialize(options = {})
        @original_ast = options[:ast]
        @type = options[:type] || @original_ast&.type
        @children = options[:children] || @original_ast&.children || []
        @location = options[:location]
        @lines = options[:lines] || extract_lines
        @value = options[:value]
        @children = @children.map { |child| Tree.node(child) }
        @comments = options[:comments] || []
      end

      def extract_lines
        if @original_ast.respond_to?(:location)
          @location = @original_ast.location

          if @location.expression
            @location.first_line..@location.last_line
          end
        end
      end

      def reconstruct_with(type: @type, children: @children, value: @value)
        unless children.empty?
          location = ::Parser::Source::Map::Collection.new(
            @lines.first,
            @lines.last,
            ::Parser::Source::Range.new(
              @location.expression.source_buffer,
              children.first.location.expression.begin_pos,
              children.last.location.expression.end_pos,
            )
          )
        end

        self.class.new(
          type: type,
          children: children,
          value: value,
          comments: @comments,
          location: location,
        )
      end

      def child
        raise StandardError.new("wrong number of children") unless children.count == 1
        children.first
      end

      def ==(other)
        type == other&.type && children == other&.children && value == other.value
      end

      def ast
        ::Parser::AST::Node.new(type, children.map(&:ast), location: @location)
      end
    end
  end
end
