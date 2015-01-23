classification::rule { 'OSX laptops':
  role  => 'test',
  match => 'any',
  rules => [
              { fact => $osfamily, operator => 'is', value => 'Darwin'   },
              { fact => $virtual,  operator => 'is', value => 'physical' },
              { fact => $hostname, operator => 'is', value => 'poodles'  },
           ],
}

classification::rule { 'webserver':
  role  => 'webserver',
  match => 'all',
  rules => [
              { fact => $osfamily,       operator => 'is',           value => 'RedHat' },
              { fact => $processorcount, operator => 'greater than', value => 2        },
           ],
}

classification::rule { 'another':
  role  => 'another',
  match => 'all',
  rules => [
              { fact => $osfamily, operator => 'regex', value => '^Dar'     },
              { fact => $virtual,  operator => 'is',    value => 'physical' },
           ],
}

classification::rule { 'inverted':
  role  => 'inverted',
  match => 'all',
  rules => [
              { fact => $osfamily, operator => 'regex', value => '^Dar',    invert => true },
              { fact => $virtual,  operator => 'is',    value => 'physical'                },
           ],
}
