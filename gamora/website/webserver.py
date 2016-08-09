from flask import json
from flask import Flask

app = Flask(__name__)

airport_database = airport_database.AirportDatabase()


@app.route('/isActive')
def get_is_active():
    return 'ACTIVE'


@app.route('/health')
def get_health():
    response = {'status': 'DOWN'}

    if airport_database.validate_airport_database():
        response = {'status': 'UP'}

    return json.dumps(response, ensure_ascii=False)


@app.route('/iata/<iata_code>')
def get_iata_code(iata_code=None):
    response = {'airportInfoStatus': {'statusCodeCategory': 'invalid_input'},
                'iataCodeNotFound': {'code': iata_code}}
    http_code = 404

    if iata_code:
        if len(iata_code) == 3:
            airport = airport_database.lookup_iata(iata_code)
            if airport:
                response = {'airportInfoStatus': {'statusCodeCategory': 'success'}, 'airport': airport}
                http_code = 200
            else:
                response = {'airportInfoStatus': {'statusCodeCategory': 'business_error'},
                            'iataCodeNotFound': {'code': iata_code}}

    return json.dumps(response, ensure_ascii=False), http_code


if __name__ == '__main__':
    app.run()