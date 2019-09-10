require "ruby_refactor/mutation/append"
require "ruby_refactor/mutation/replace"

class RubyRefactor
  class Mutation
    def self.chain(parser, *mutations)
      mutations.each do |mutation|
        evolve(parser, mutation)
      end

      parser.rewriter.process
    end

    def self.evolve(rewriter, mutation)
      mutator_class(mutation).new(rewriter).run(*mutation[1..-1])
    end

    def self.mutator_class(mutation)
      mutator = mutation[0]
      Mutation.const_get(mutator.capitalize.to_s)
    end
  end
end
