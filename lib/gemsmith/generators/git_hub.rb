# frozen_string_literal: true

module Gemsmith
  module Generators
    # Generates GitHub support.
    class GitHub < Base
      def run
        return unless configuration.dig(:generate, :git_hub)
        cli.template "%gem_name%/.github/ISSUE_TEMPLATE.md.tt", configuration
        cli.template "%gem_name%/.github/PULL_REQUEST_TEMPLATE.md.tt", configuration
      end
    end
  end
end
