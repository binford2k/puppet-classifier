Puppet::Parser::Functions.newfunction(:classification_match,
  :type  => :rvalue,
  :arity => 2,
  :doc   => 'Return true if the given ruleset matches'
) do |args|
  kind, rules = args

  raise Puppet::ParseError, "Invalid match type: #{kind}, expected 'all', or 'any'" unless ['all', 'any'].include? kind
  raise Puppet::ParseError, "Ruleset must be an Array of Hashes" unless rules.class == Array

  matching = rules.select do |rule|
    if rule['fact'].nil? or rule['value'].nil?
      raise Puppet::ParseError, 'Both fact and value parameters are required'
    end

    operators = ['is', 'regex', 'greater than', 'greater or equal', 'less than', 'less or equal']
    unless operators.include? rule['operator']
      raise Puppet::ParseError, "Operator must be one of #{operators.inspect}"
    end

    unless [true, false, nil].include? rule['invert']
      raise Puppet::ParseError, 'Invert parameter must be a boolean value'
    end

    match = case rule['operator']
    when 'is'
      rule['fact'] == rule['value']
    when 'regex'
      rule['fact'] =~ Regexp.compile(rule['value'])
    when 'greater than'
      function_versioncmp([rule['fact'], rule['value']]) ==  1
    when 'greater or equal'
      function_versioncmp([rule['fact'], rule['value']]) != -1
    when 'less than'
      function_versioncmp([rule['fact'], rule['value']]) == -1
    when 'less or equal'
      function_versioncmp([rule['fact'], rule['value']]) !=  1
    end

    rule['invert'] ? ! match : match
  end

  if kind == 'all'
    rules.size == matching.size
  else
    matching.size > 0
  end
end