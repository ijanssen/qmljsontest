/// API base url for request
var API_HOST = ''
//var API_HOST = ''
/// Web application url for request
var WEBAPP_HOST = ''
/// Set LAST_MSG_TIMESTAMP on login or not and receive all message for test.
var GET_LAST_FLAG = true

/// Access token
var ACCESS_TOKEN = ''
/// Selected hospital identificator
var HOSPITAL_ID = ''
/// Timestamp for last get new message call
var LAST_MSG_TIMESTAMP = 0

/// On login success request handler
var onLogin
/// On login set hospital success request handler
var onLoginSetHospital
/// On logout success request handler
var onLogout
/// On login error handler
var onLoginError
/// On request error handler
var onReqError


/*!
 * \brief Send login REST API request and parse response. Add received hospitals to ListModel for next selection.
 *  Set ACCESS_TOKEN variable. Call onLogin handler on success.
 * \param model link to ListModel object for messages
 * \param login login string value
 * \param password password string value
 */
function login(model, login, password) {
    var request = new XMLHttpRequest()
    request.open('POST', API_HOST + '/login', true)

    request.onreadystatechange = function() {
        console.log('stat ', request.readyState)
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var res = request.getResponseHeader('Api')
                if (res !== 'ok') {
                    onLoginError('Login error')
                    return
                }
                console.log("response", request.responseText)
                var result = JSON.parse(request.responseText)
                ACCESS_TOKEN = result.reply[0];
                model.clear();
                for (var i = 0; i < result.reply[1].length; i++) {
                    var h = result.reply[1][i];
                    model.append({id: h[0], name: h[1]});
                }
                onLogin()
            } else {
                onLoginError('HTTP: ' + request.status + ' ' + request.statusText)
            }
        }
    }
    request.onerror = function(e) {
        console.log('error', e)
    }

    request.timeout = 10000
    request.ontimeout = function () {
        console.log('timeout')
    }

    //request.ontimeout
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    var body = 'login_type=mus_email&login=%1&password=%2'.arg(encodeURIComponent(login)).arg(encodeURIComponent(password))
    console.log(body)
    request.send(body)
}

/*!
 * \brief Send set hospital REST API request and parse response. Set HOSPITAL_ID variable. Call onLoginSetHospital handler on success.
 * \param hospitalid Selected hospital string identificator
 */

function loginSetHospital(hospitalid) {
    var request = new XMLHttpRequest()
    request.open('POST', API_HOST + '/login_set_hospital', true)
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var res = request.getResponseHeader('Api')
                if (res !== 'ok') {
                    onLoginError('Login error')
                    return
                }
                var result = JSON.parse(request.responseText)
                HOSPITAL_ID = hospitalid
                if (GET_LAST_FLAG)
                    LAST_MSG_TIMESTAMP = result.reply[1]

                onLoginSetHospital()
            } else {
                onLoginError('HTTP: ' + request.status + ' ' + request.statusText)
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    request.setRequestHeader('Access-token', ACCESS_TOKEN)
    var body = 'hospital_id=' + hospitalid
    console.log(body)
    request.send(body)
}

/*!
 * \brief Send logout REST API request. Call onLogout handler on success.
 */
function logout() {
    var request = new XMLHttpRequest()
    request.open('POST', API_HOST + '/auth', true)
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var res = request.getResponseHeader('Api')
                if (res !== 'ok') {
                    onReqError('Request error')
                    return
                }
                //console.log("response", request.responseText)
                ACCESS_TOKEN = ''
                HOSPITAL_ID = ''
                LAST_MSG_TIMESTAMP = 0
                onLogout()
            } else {
                onReqError('HTTP: ' + request.status + ' ' + request.statusText)
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    request.setRequestHeader('Access-token', ACCESS_TOKEN)
    var body = 'action=logout'
    request.send(body)
}


/*!
 * \brief Send get new messages REST API request and parse response. Add messages to ListModel. Update LAST_MSG_TIMESTAMP variable.
 * \param model link to ListModel object for messages
 */
function messageGetNew(model) {
    var request = new XMLHttpRequest()
    request.open('POST', API_HOST + '/message', true)
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var res = request.getResponseHeader('Api')
                if (res !== 'ok') {
                    onReqError('API error')
                    return
                }
                var result = JSON.parse(request.responseText)
                LAST_MSG_TIMESTAMP = result.reply[0]

                for (var m = 0; m < result.reply[1].length; m++) {
                    var msg = result.reply[1][m];
                    console.log(result.reply[1][m][6])
                    model.append({mid: msg[0], time: msg[1], txt: msg[6]});
                }
            } else {
                onReqError('HTTP: ' + request.status + ' ' + request.statusText)
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    request.setRequestHeader('Access-token', ACCESS_TOKEN)
    request.setRequestHeader('Last-action-time', LAST_MSG_TIMESTAMP)
    var body = 'action=get_new'
    request.send(body)
}
