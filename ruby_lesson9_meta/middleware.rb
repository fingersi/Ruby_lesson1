# frozen_string_literal: true

class MiddleWare
  def initialize(texts)
    @texts = texts
  end

  def block_it(instance)
    block = proc do |obj|
      puts obj.methods
    end
    apply_block(instance, block)
  end

  private

  def apply_block(instance, block)
    instance.block.each { |x| block.call(x) }
  end
end
