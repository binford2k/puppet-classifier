# Rules Based Classifier

So you want to use the new rules based node classifier, but need your classification
to be version controlled? Don't want to abandon your existing roles and profiles
organization? Then this is the solution for you.

There are two options for defining your rules.

## Defining rules directly in code:

Drop rules like the following in your `default` node:

``` Puppet
node default {
  classification::rule { 'OSX laptops':
    role  => 'workstation',
    match => 'all',
    rules => [ 
                { fact => $osfamily, operator => 'is', value => 'Darwin'   },
                { fact => $virtual,  operator => 'is', value => 'physical' },
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
}
```

## Defining rules in Hiera

Simply include the class in your default node

``` Puppet
node default {
  include classification
}
```

Then you'll need to define rules in a Hiera datasource. That might look something like

``` Yaml
---
classification::rules:
  OSX laptops:
    role: workstation
    match: all
    rules:
      - { fact => %osfamily, operator => 'is', value => 'Darwin'   }
      - { fact => %virtual,  operator => 'is', value => 'physical' }
  webserver:
    role: webserver
    match: all
    rules:
      - { fact => %osfamily,        operator => 'is',           value => 'RedHat' }
      - { fact => %processorcount,  operator => 'greater than', value => 2        }

```

## Disclaimer

This is a toy project and was written in about 1.5 hours. You get what you pay for.

Contact
-------

binford2k@gmail.com
