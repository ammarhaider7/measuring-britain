// Generated by CoffeeScript 1.10.0
var districts;

districts = require('../../../../json/geography/districts.json');

module.exports = {
  category_options: [
    {
      value: 'countries',
      label: 'Geography (Countries)'
    }, {
      value: 'districts',
      label: 'Geography (Districts)'
    }, {
      value: 'regions',
      label: 'Geography (Regions)'
    }, {
      value: 'ethnicities',
      label: 'Ethnic Group'
    }, {
      value: 'religions',
      label: 'Religion'
    }
  ],
  countries: [
    {
      value: 'K04000001',
      label: 'England \& Wales'
    }, {
      value: 'E92000001',
      label: 'England'
    }, {
      value: 'W92000004',
      label: 'Wales'
    }
  ],
  districts: districts,
  ethnic_groups: [
    {
      value: '1',
      label: 'White'
    }, {
      value: '17',
      label: 'Black'
    }, {
      value: '11',
      label: 'Asian'
    }, {
      value: '6',
      label: 'Mixed'
    }, {
      value: '22',
      label: 'Arab'
    }, {
      value: '21',
      label: 'Other'
    }
  ],
  religions: [
    {
      value: '1',
      label: 'Christian'
    }, {
      value: '5',
      label: 'Muslim'
    }, {
      value: '3',
      label: 'Hindu'
    }, {
      value: '2',
      label: 'Buddhist'
    }, {
      value: '4',
      label: 'Jewish'
    }, {
      value: '6',
      label: 'Sikh'
    }, {
      value: '7',
      label: 'Other religion'
    }, {
      value: '8',
      label: 'No religion'
    }, {
      value: '9',
      label: 'Religion not stated'
    }
  ],
  regions: [
    {
      value: '2013265921',
      label: 'North East'
    }, {
      value: '2013265922',
      label: 'North West'
    }, {
      value: '2013265923',
      label: 'Yorkshire and The Humber'
    }, {
      value: '2013265924',
      label: 'East Midlands'
    }, {
      value: '2013265925',
      label: 'West Midlands'
    }, {
      value: '2013265926',
      label: 'East'
    }, {
      value: '2013265927',
      label: 'London'
    }, {
      value: '2013265928',
      label: 'South East'
    }, {
      value: '2013265929',
      label: 'South West'
    }, {
      value: '2013265930',
      label: 'Wales'
    }
  ]
};
