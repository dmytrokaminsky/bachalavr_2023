class Audit < Audited::Audit
  MODELS = %w[Answer Question Round Result Theme User].freeze

  def output
    [I18n.t("activerecord.models.#{auditable_type.downcase}"), "##{auditable_id}"].join(' ')
  end

end
