import time
import urllib

import invoke_ourweather
import json


def timer_start():
    start_time = time.time()
    return start_time


def timer_check(time_passed, method_type):
    end_time = time.time() - time_passed
    if end_time > 60:
        response = "An Error has been encountered with " + method_type + " It has taken: " + str(
            end_time) + " Between Responses"
        invoke_ourweather.file_operate("ErrorFile", response)


if '__main__' == __name__:
    method = "Hello"
    a = timer_start()
    time.sleep(30)
    timer_check(a, method)
    a = timer_start()
    time.sleep(61)
    timer_check(a, method)
    print("over lol")
