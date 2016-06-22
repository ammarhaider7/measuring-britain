data = {
	# max 3 thumbails per section
	demographics: [

		{
			href: '/census/population-pyramid'
			img: '/images/population-pyramid.PNG'
			chart_name: 'Population Pyramid'
			description: 'Distribution of the population by age and gender. Filter by geography, ethnicity and religion.'
		}
		{
			href: '/census/ethnic-diversity'
			img: '/images/ethnic-diversity.PNG'
			chart_name: 'Ethnic Diversity'
			description: 'Ethnic breakdown of the population, offers two layers of detail. Filter by geography and religion.'
		}
		{
			href: '/census/religious-diversity'
			img: '/images/religious-diversity.PNG'
			chart_name: 'Religious Diversity'
			description: 'Religious breakdown of the population. Filter by geography and ethnicity.'
		}

	]

	health: [

		{
			href: '/census/ethnic-disparities-general-health'
			img: '/images/ethnic-disparities-health.PNG'
			chart_name: 'Ethnic Disparities by General Health'
			description: 'The Ethnic Disparities in General Health chart shows the percentage of the population with self-proclaimed bad or very bad health broken down by age group and ethnicity. There is an additional gender filter.'
		}
		{
			href: '/census/longterm-illness-disability-by-ethnicity'
			img: '/images/health-disability.PNG'
			chart_name: 'Long-term illness or disability by ethnicity'
			description: 'The ethnic Disparities in long-term illness and disability chart shows the number and percentage of the population with a long-term illness or disability broken down by age group and ethnicity.'
		}

	]

	labour: [

		{
			href: '/census/employment-status-by-country-of-birth'
			img: '/images/econ-by-country.PNG'
			chart_name: 'Employment status by country of birth'
			description: 'This chart shows the proportion of people in work and out of work. This is further broken down by the type/reason of their employment status.'
		}

	]

}

module.exports = data