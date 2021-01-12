from win32 import win32clipboard
from time import gmtime
from os import mkdir
from os.path import exists, expanduser


def get_timestamp():
    now = gmtime()
    return f"{now.tm_mday}-{now.tm_mon}-{now.tm_year} {now.tm_hour}-{now.tm_min}-{now.tm_sec}"


bmp_header_hex = "424d000000000000000042000000"

image_path = expanduser("~") + "/Pictures/Screenshots/"

win32clipboard.OpenClipboard()
if win32clipboard.IsClipboardFormatAvailable(win32clipboard.CF_DIB):
    data = win32clipboard.GetClipboardData(win32clipboard.CF_DIB)

    if not exists(image_path):
        mkdir(image_path)

    with open(f"{image_path}{get_timestamp()}.bmp", "wb") as f:
        f.write(bytearray.fromhex(bmp_header_hex))
        f.write(data)

    win32clipboard.EmptyClipboard()
win32clipboard.CloseClipboard()
