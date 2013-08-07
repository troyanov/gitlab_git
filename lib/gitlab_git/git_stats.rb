require_relative 'log_parser'

module Gitlab
  module Git
    class GitStats
      attr_accessor :repo, :ref, :branch

      def initialize repo, ref, branch
        @repo, @ref, @branch = repo, ref, branch
      end

      def log
        args = ['--format=%aN%x0a%ad', '--date=short', '--shortstat', '--no-merges', @branch]
        repo.git.run(nil, 'log', nil, {}, args)
      rescue Grit::Git::GitTimeout
        nil
      end

      def parsed_log
        LogParser.parse_log(log)
      end
    end
  end
end
