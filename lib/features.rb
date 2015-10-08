module Features
  def with_feature(feature)
    if enabled? feature
      yield
    end
  end

  def without_feature(feature)
    unless enabled? feature
      yield
    end
  end

  def enabled?(feature)
    Settings.features && (Settings.features.all || Settings.features[feature])
  end
end
