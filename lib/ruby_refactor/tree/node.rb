require "range"
require "unparser"
require "ruby_refactor/tree/searchable"

class RubyRefactor
  class Tree
    class Node
      include Searchable
      attr_reader :type, :children, :value, :lines
      attr_accessor :comments

      def initialize(options = {})
        @original_ast = options[:ast]
        @type = options[:type] || @original_ast&.type
        @children = options[:children] || @original_ast&.children || []
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
        self.class.new(
          type: type,
          children: children,
          value: value,
          comments: @comments,
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
        Parser::AST::Node.new(type, children.map(&:ast), location: @location)
      end
    end
  end
end
