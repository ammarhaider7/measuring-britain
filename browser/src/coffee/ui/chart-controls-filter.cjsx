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
		                if category.value is @props._outlineCategory.value then return category.label
		            }
		            onChange={ @props.onOutlineCategoryChange }
		          />
		        </div>
		        <div className="mb-form-group category-group col-sm-6 mb-oxygen">
		          <FancySelect
		            className="mb-input-sm"
		            placeholder={ do =>
		              for category in @props.categories
		                if category.value is @props._outlineCategory.value
		                  return 'Search ' + category.value + '..'
		                else if category.value isnt @props._outlineCategory.value
		                  continue
		              return '2. Choose a value'  
		            }
              		value={ if @props._outlineValue.value isnt 'default' then @props._outlineValue.label }
		            options={ do =>
		              for category in @props.categories
		                if category.value is @props._outlineCategory.value then return @props.values[category.value]
		            }
              		onChange={ @props.onOutlineValueChange }
		          />
		        </div>
		    </div>
	        <div className="col-sm-2 col-md-3 mb-no-padding">
	          { do =>
	            if @props.chartName is 'pyramid'
	              <button 
	                className="btn btn-sm btn-default mb-oxygen mb-small-btn-gradient" 
	                type="button" 
	                onClick={ @props.onRemoveFilter }
	              >
	                <span className={ "glyphicon glyphicon-minus" }/>
	              </button>
	          }
	        </div>
		</div>

module.exports = Filter