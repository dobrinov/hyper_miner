# Hyper miner

[![Gem Version](https://badge.fury.io/rb/hyper_miner.svg)](http://badge.fury.io/rb/hyper_miner)
[![Code Climate](https://codeclimate.com/github/dobrinov/hyper_miner/badges/gpa.svg)](https://codeclimate.com/github/dobrinov/hyper_miner)

## Information
A simple web data mining ruby gem. It allows you to extract data from a page based on instructions defined with a DSL.

## Installation
```
[sudo] gem install hyper_miner
```

## Usage

##### Example
```ruby
require 'hyper_miner'

miner = HyperMiner.new('http://www.cdc.gov/vhf/ebola/outbreaks/2014-west-africa/case-counts.html')

mined_data = miner.mine do
  text    'title',           selector: 'div#countries-widespread-ebola-transmission > h2'
  integer 'total_cases',     selector: 'table#cases-widespread tr:last-child td:nth-child(2)'
  integer 'total_lab_cases', selector: 'table#cases-widespread tr:last-child td:nth-child(3)'
  integer 'total_deaths',    selector: 'table#cases-widespread tr:last-child td:nth-child(4)'
end

p mined_data
```

##### Persist or use the result data as you wish
```
{
  "total_cases"     => 13540,
  "total_lab_cases" => 7702,
  "total_deaths"    => 4941
}
```
