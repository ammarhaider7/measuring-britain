React = require 'react'
FancySelect = require 'react-select'

Filter = React.createClass
	render: ->
		<div className="col-sm-12 row mt-small">
			<div className="col-sm-9 mb-no-padding">
				<label className="col-sm-1">Outline</label>
		        <div className="mb-form-group col-sm-5 mb-oxygen">
		          <FancySelect
		            className="mb-input-sm"
		            placeholder="1. Choose a category"
		            options={ @props.categories }
		            value={ do =>
		              for category in @props.categories
		                if category.value is @props.outlineCategory then return category.label
		            }
		            onChange={ @props.onOutlineCategoryChange }
		          />
		        </div>
		        <div className="mb-form-group category-group col-sm-6 mb-oxygen">
		          <FancySelect
		            className="mb-input-sm"
		            placeholder={ do =>
		              for category in @props.categories
		                if category.value is @props.outlineCategory
		                  return 'Search ' + category.value + '..'
		                else if category.value isnt @props.outlineCategory
		                  continue
		              return '2. Choose a value'  
		            }
		            options={ do =>
		              for category in @props.categories
		                if category.value is @props.outlineCategory then return @props.values[category.value]
		            }
		          />
		        </div>
		    </div>
		</div>

module.exports = Filter