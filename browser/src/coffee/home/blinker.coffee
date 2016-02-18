$ = require 'jQuery'

# code gets installed at the end of the body (after all other HTML)
module.exports = do ->

	quotes = $ ".mb-quotes"
	quoteIndex = -1
	showNextQuote = ->
	    ++quoteIndex;
	    quotes.eq(quoteIndex % quotes.length)
	        .fadeIn(500)
	        .delay(500)
	        .fadeOut(500, showNextQuote)

	showNextQuote()