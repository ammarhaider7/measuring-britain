TOGGLE_FILTER = "TOGGLE_FILTER"
TOGGLE_CATEGORY = "TOGGLE_CATEGORY"
MOUSE_OVER = "MOUSE_OVER"	
# toggleFilter options should take the form of:-
# {
# 	category= [category],
# 	value= [value]
# }
toggleFilter = (filterOptions) ->
	{
		type: TOGGLE_FILTER
		filterOptions
	}

toggleCategory =  (category) ->
	{
		type: TOGGLE_CATEGORY
		category
	}
# mouseOver options should take the form of:-
# {
# 	chart= [chart],
# 	segment= [segment]
# }
mouseOver = (mouseOverOptions) ->
	{
		type: MOUSE_OVER
		mouseOverOptions
	}

# boundToggleFilter = (filterOptions) ->
# 	dispatch(toggleFilter(options))

# boundToggleCategory = (category) ->
# 	dispatch(toggleCategory(category))

# boundMouseOver = (mouseOverOptions) ->
# 	dispatch(mouseOver(options))

module.exports = {
	TOGGLE_FILTER
	TOGGLE_CATEGORY
	MOUSE_OVER
	toggleFilter
	toggleCategory
	mouseOver
	# boundMouseOver
	# boundToggleCategory
	# boundToggleFilter
}