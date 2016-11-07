# frozen_string_literal: true

module Gemsmith
  module Skeletons
    # Configures default gem support.
    class GemSkeleton < BaseSkeleton
      def create
        cli.template "%gem_name%/bin/setup.tt", configuration
        cli.template "%gem_name%/Gemfile.tt", configuration
        cli.template "%gem_name%/%gem_name%.gemspec.tt", configuration
        cli.template "#{lib_gem_root}.rb.tt", configuration
        cli.template "#{lib_gem_root}/identity.rb.tt", configuration
        cli.chmod "#{configuration.dig(:gem, :name)}/bin/setup", 0o755
      end
    end
  end
end
