Nav = React.createClass 

	render: ->

		<nav className={if @props.border is 'yes' then "navbar navbar-default navbar-static-top mb-nav-border" else "navbar navbar-default navbar-static-top"}>
			<div className={if @props.alt_bg is 'yes' then "container mb-alt-bg mb-full-width" else "container"}>
				<div className="navbar-header">
					<button type="button" className="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
						<span className="sr-only">Toggle navigation</span>
						<span className="icon-bar"></span>
						<span className="icon-bar"></span>
						<span className="icon-bar"></span>
					</button>
					<a className={if @props.alt_bg is 'yes' then "mb-nav-brand-font navbar-brand mb-white-text" else "mb-nav-brand-font navbar-brand"} href="/">Measuring Britain</a>
				</div>
				<div id="navbar" className="navbar-collapse collapse" aria-expanded="false" style={{height: '1px'}}>
					<ul className="nav navbar-nav">
						<li className={ if @props.active is "home" then 'active' else ''}>
							<a className={if @props.alt_bg is 'yes' then 'mb-white-text'} href="/">
								<i className="fa fa-home fa-lg fa-fw"></i>
							</a>
						</li>
						<li className={ if @props.active is "census" then 'dropdown active' else 'dropdown'}>
							<a href="/demographics" className={if @props.alt_bg is 'yes' then 'dropdown-toggle mb-white-text' else "dropdown-toggle"} data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Census <span className="caret"></span></a>
							<ul className="dropdown-menu">
								<li><a href="/census">Census Home</a></li>
								<li role="separator" className="divider"></li>
								<li className="dropdown-header">Demographics</li>
								<li><a href="/census/population-pyramid">Population Pyramid</a></li>
								<li><a href="/census/ethnic-diversity">Ethnic Diversity</a></li>
								<li><a href="/census/religious-diversity">Religious Diversity</a></li>
								<li role="separator" className="divider"></li>
								<li className="dropdown-header">Health</li>
								<li><a href="/census/ethnic-disparities-general-health">Ethnic Disparities in General Health</a></li>
								<li><a href="/census/longterm-illness-disability-by-ethnicity	">Long-term illness/disability by ethnicity</a></li>
								<li role="separator" className="divider"></li>
								<li className="dropdown-header">Labour market</li>
								<li><a href="/census/employment-status-by-country-of-birth">Employment status by country of birth</a></li>
							</ul>
						</li>
						<li className={ if @props.active is "demographics" then 'dropdown active' else 'dropdown'}>
							<a href="/demographics" className={if @props.alt_bg is 'yes' then 'dropdown-toggle mb-white-text' else "dropdown-toggle"} data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Demographics <span className="caret"></span></a>
							<ul className="dropdown-menu">
								{###<li role="separator" className="divider"></li>###}
								<li className="dropdown-header">Census</li>
								<li><a href="/census/population-pyramid">Population Pyramid</a></li>
								<li><a href="/census/ethnic-diversity">Ethnic Diversity</a></li>
								<li><a href="/census/religious-diversity">Religious Diversity</a></li>
							</ul>
						</li>
						<li className={ if @props.active is "health" then 'dropdown active' else 'dropdown'}>
							<a href="/health" className={if @props.alt_bg is 'yes' then 'dropdown-toggle mb-white-text' else "dropdown-toggle"} data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Health <span className="caret"></span></a>
							<ul className="dropdown-menu">
								{###<li role="separator" className="divider"></li>###}
								<li className="dropdown-header">Census</li>
								<li><a href="/census/ethnic-disparities-general-health">Ethnic Disparities in General Health</a></li>
								<li><a href="/census/longterm-illness-disability-by-ethnicity">Long-term illness/disability by ethnicity</a></li>
							</ul>
						</li>
						<li className={ if @props.active is "health" then 'dropdown active' else 'dropdown'}>
							<a href="#" className={if @props.alt_bg is 'yes' then 'dropdown-toggle mb-white-text' else "dropdown-toggle"} data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Labour Market <span className="caret"></span></a>
							<ul className="dropdown-menu">
								{###<li role="separator" className="divider"></li>###}
								<li className="dropdown-header">Census</li>
								<li><a href="/census/employment-status-by-country-of-birth">Employment Status by Country of Birth</a></li>
							</ul>
						</li>
						<li className={ if @props.active is "about" then 'active' else ''}}><a className={if @props.alt_bg is 'yes' then 'mb-white-text'} href="/about">About</a></li>
					</ul>
					<ul className="nav navbar-nav navbar-right">
						<li>
							<a href="#"><i className="fa fa-facebook fa-lg fa-fw"></i></a>
						</li>	
						<li>
							<a href="#"><i className="fa fa-twitter fa-lg fa-fw"></i></a>
						</li>
						<li>
							<a href="https://github.com/ammarhaider7/measuring-britain" target="_blank"><i className="fa fa-github fa-lg fa-fw"></i></a>
						</li>	
						<li>
							<a href="#"><i className="fa fa-trello fa-lg fa-fw"></i></a>
						</li>	
					</ul>
				</div>
			</div>
		</nav>

module.exports = Nav