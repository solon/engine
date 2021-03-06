module Locomotive
  class ThemeAssetPresenter < BasePresenter

    ## properties ##

    properties  :content_type,  :folder
    property    :plain_text,    :allow_nil => false

    with_options :only_setter => true do |presenter|
      presenter.properties :plain_text_name, :plain_text_type, :performing_plain_text, :source
    end

    with_options :only_getter => true do |presenter|
      presenter.properties :local_path, :url, :size, :raw_size, :dimensions, :can_be_deleted
    end

    ## other getters / setters ##

    def local_path
      self.source.local_path(true)
    end

    def url
      self.source.source.url
    end

    def size
      number_to_human_size(self.source.size)
    end

    def raw_size
      self.source.size
    end

    def dimensions
      self.source.image? ? "#{self.source.width}px x #{self.source.height}px" : nil
    end

    def updated_at
      I18n.l(self.source.updated_at, :format => :short)
    end

    def can_be_deleted
      self.ability.try(:can?, :destroy, self.source)
    end

    def plain_text
      plain_text? ? self.source.plain_text : nil
    end

    ## methods ##

    protected

    def plain_text?
      # FIXME: self.options contains all the options passed by the responder
      self.options[:template] == 'update' && self.source.errors.empty? && self.source.stylesheet_or_javascript?
    end

  end
end
