class classification {
  create_resources('classification::rule', hiera('classification::rules', {}))
}