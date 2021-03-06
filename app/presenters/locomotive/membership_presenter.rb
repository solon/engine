module Locomotive
  class MembershipPresenter < BasePresenter

    ## properties ##

    property    :role
    properties  :role_name, :can_update, :grant_admin, :only_getter => true
    property    :account_id
    properties  :name, :email, :only_getter => true

    ## other getters / setters ##

    def name
      self.source.account.name
    end

    def role_name
      I18n.t("locomotive.memberships.roles.#{self.source.role}")
    end

    def email
      self.source.account.email
    end

    def can_update
      return nil unless self.ability?
      self.ability.can? :update, self.source
    end

    def grant_admin
      return nil unless self.ability?
      self.ability.can? :grant_admin, self.source
    end

  end
end
