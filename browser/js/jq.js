/**
 * @api {get} /user/:id Request User information
 * @apiName GetUser
 * @apiGroup User
 *
 * @apiParam {Number} id Users unique ID.
 *
 * @apiSuccess {String} firstname Firstname of the User.
 * @apiSuccess {String} lastname  Lastname of the User.#
 */

var hello = function (name) {
	console.log("Hello " + name + "!");
	console.log('$ is :' + !!$);	
	console.log("jquery log");
};

module.exports = hello;