require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/confoo2017_jsonapi'
require_relative '../apps/api/application'

Hanami.configure do
  mount Api::Application, at: '/api'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/confoo2017_jsonapi_development.sqlite3'
    #    adapter :sql, 'postgres://localhost/confoo2017_jsonapi_development'
    #    adapter :sql, 'mysql://localhost/confoo2017_jsonapi_development'
    #
    adapter :sql, ENV['DATABASE_URL']

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root Hanami.root.join('lib', 'confoo2017_jsonapi', 'mailers')

    # See http://hanamirb.org/guides/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :info
  end

  environment :production do
    logger level: :info, formatter: :json

    mailer do
      delivery :smtp, address: ENV['SMTP_HOST'], port: ENV['SMTP_PORT']
    end
  end
end
