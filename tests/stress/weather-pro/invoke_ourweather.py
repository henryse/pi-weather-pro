import urllib.request
import datetime
import argparse
# --url=192.168.0.58 --method=OutdoorTemperature


def get_page(path, sub_path):
    complete_url = 'http://' + path + '/' + sub_path
    with urllib.request.urlopen(complete_url) as response:
        full_response = response.read()
    return full_response


def file_operate(page, content):
    file_name = page + '.txt'
    with open(file_name, "a") as myfile:
        return myfile.write(content)


def get_arguments():
    parser = argparse.ArgumentParser(description='Intake Arguments')
    parser.add_argument('-u', '--url', type=str,
                        help="Url Path, dont add http://, for example only 192.168.0.58",
                        required=True)
    parser.add_argument('-m', '--method', type=str,
                        help="Method refers to which path you want to go to i.e. Altitude gives you /Altitude",
                        required=True)
    parser.add_argument('-f', '--filepath', type=str,
                        help="Sets Destination path of files that are created",
                        required=False)
    args = parser.parse_args()
    method_argument = args.method
    url_argument = args.url
    file_path_argument = args.filepath
    if args.filepath is not None:
        method_argument = file_path_argument + method_argument
    return method_argument, url_argument


def execute(target_method, target_url):
    target_answer = str(datetime.datetime.now()) + ": " + str(get_page(target_url, target_method), 'utf-8')
    file_operate(target_method, target_answer)

if '__main__' == __name__:
    method, url = get_arguments()
    execute(method, url)
