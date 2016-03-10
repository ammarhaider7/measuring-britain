TOGGLE_CATEGORY = "TOGGLE_CATEGORY"
MOUSE_OVER = "MOUSE_OVER"

# toggleFilter options should take the form of:-
# {
# 	category= [category],
# 	value= [value]
# }

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

module.exports = {
	TOGGLE_CATEGORY
	MOUSE_OVER
	toggleCategory
	mouseOver
}