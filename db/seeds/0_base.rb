# frozen_string_literal: true

require 'etc'

module Seeds
  class Base
    attr_reader :mutex

    def self.seed
      raise('Only supposed to be ran in Development') unless Rails.env.development?

      Rails.logger.info "Running #{self}..."
      new.generate!
    end

    def generate!
      raise NotImplementedError
    end

    def initialize
      @mutex = Mutex.new
    end

    private

    def array_of_attributes(count)
      bar = create_bar("Seeding #{self.class.name}", count)
      mutex = Mutex.new

      num_threads = Etc.nprocessors - 1
      chunk_size = count / num_threads
      remainder = count % num_threads

      (1..num_threads).map do |i|
        current_chunk_size = i == num_threads ? chunk_size + remainder : chunk_size

        Dry::Monads::Task[:io] do
          Array.new(current_chunk_size) do
            attrs = klass_attributes
            mutex.synchronize { bar.advance }
            attrs
          end
        end
      end.map(&:value!).flatten
    end

    def klass_attributes(bar)
      raise NotImplementedError
    end

    def create_bar(text, total)
      pastel = Pastel.new
      green  = pastel.on_green(' ')

      TTY::ProgressBar.new("#{text} |:bar|",
                           total:,
                           complete: green)
    end
  end
end
