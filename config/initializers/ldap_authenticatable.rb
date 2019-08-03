require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable
      def authenticate!
        return unless params[:user]

        ldap = Net::LDAP.new
        ldap.host = 'ldap.dcc.ufmg.br'
        ldap.base = 'dc=dcc,dc=ufmg,dc=br'
        ldap.auth "uid=#{login},ou=People,dc=dcc,dc=ufmg,dc=br", password

        begin
          raise(:invalid_login) unless ldap.bind

          unless (user = User.find_by(email: email))
            filter = Net::LDAP::Filter.eq('uid', login)
            ldap_user = {}
            ldap.search(filter: filter) do |entry|
              ldap_user['first_name'] = entry.givenname[0]
              ldap_user['last_name'] = entry.sn[0]
              user = User.find_or_create_by(email: email)
              user.update_attributes(ldap_user)
              user.skip_confirmation_notification!
              user.save
            end
          end

          success!(user)
        rescue Net::LDAP::Error
          return
        end
      end

      def login
        params[:user][:email].gsub('@dcc.ufmg.br', '')
      end

      def email
        params[:user][:email]
      end

      def password
        params[:user][:password]
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)
