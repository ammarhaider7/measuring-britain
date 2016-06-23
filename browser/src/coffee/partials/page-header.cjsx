PageHeader = React.createClass 

	capitalizeFirstLetter: (str) ->
		return str.charAt(0).toUpperCase() + str.slice 1
	render: ->

		<div className="mb-page-header mb-hidden-mp">
		    <div className="container">
		        <h1 className="text-center">{ @capitalizeFirstLetter @props.page_header }</h1>               
		    </div>
		</div>

module.exports = PageHeader