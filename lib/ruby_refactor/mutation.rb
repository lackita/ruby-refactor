require "ruby_refactor/mutation/append"
require "ruby_refactor/mutation/compact"
require "ruby_refactor/mutation/replace"

class RubyRefactor
  class Mutation
    def self.chain(start, *mutations)
      mutations.map do |mutation|
        new(mutation)
      end.reduce(start) do |tree, mutation|
        mutation.evolve(tree)
      end
    end

    def initialize(mutation)
      @mutator = mutation[0]
      @variation = mutation[1..-1]
    end

    def evolve(tree)
      mutator(tree).run(*@variation)
    end

    def mutator(tree)
      mutator_class.new(tree)
    end

    def mutator_class
      Mutation.const_get(@mutator.capitalize.to_s)
    end
  end
end
