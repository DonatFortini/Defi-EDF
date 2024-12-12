import easyocr
import json
import os
import re
from PIL import Image

class Model:
    def __init__(self):
        self.reader = easyocr.Reader(['fr'], gpu=True)
        self.home_path = os.getcwd()
        self.regex = [r"[A-Z]{2}-[0-9]{1,3}-[A-Z]{2}", r"\b\d+\s?(km|KM|Km|kn|Kn)\b"]

    def clean_output(self, output: list[tuple], type: int) -> str:
        if type == 1 or type == 0:
            for item in output:    
                item=item[1]
                if re.match(self.regex[type], item):
                    if type == 0:
                        return item if len(item) == 9 else item[:-1]
                    return item
            return "No match found"            
        else:
            raise Exception("Type not supported")

    def perform(self, filepath: str, type: int) -> str:
        list_allowed = '0123456789AZERTYUIOPQSDFGHJKLMWXCVBNazertyuiopqsdfghjklmwxcvbn-'
        content = self.reader.readtext(filepath, allowlist=list_allowed,adjust_contrast=2.0)
        return self.clean_output(content, type)



