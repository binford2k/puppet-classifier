define classification::rule (
  $role  = undef,
  $match = 'all',
  $rules = undef,
) {
  if $role == undef {
    fail('$role parameters is required')
  }

  if classification_match($match, $rules) {
    include("role::${role}")
  }
}
