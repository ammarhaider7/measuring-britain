districts = require '../../../../json/geography/districts.json'

module.exports =
	category_options: [
		{
			value: 'districts'
			label: 'Geography (Districts)'
		},
		{
			value: 'regions'
			label: 'Geography (Regions)'
		},
		{
			value: 'ethnicities'
			label: 'Ethnic Group'
		},
		{
			value: 'religions'
			label: 'Religion'
		}
	],
	districts: districts,
	ethnic_groups: [
		{
			value: '1'
			label: 'White'
		},
		{
			value: '2'
			label: 'Black'
		},
		{
			value: '3'
			label: 'Asian'
		},
		{
			value: '4'
			label: 'Other'
		},				
	],
	religions: [
		{
			value: '1'
			label: 'Christian'
		},
		{
			value: '2'
			label: 'Muslim'
		},
		{
			value: '3'
			label: 'Hindu'
		},
		{
			value: '4'
			label: 'Buddhist'
		},		
	],
	regions: [
		{
			value: '1'
			label: 'NW'
		},
		{
			value: '2'
			label: 'SE'
		},
		{
			value: '3'
			label: 'NE'
		},
		{
			value: '4'
			label: 'MID'
		},	
	]
