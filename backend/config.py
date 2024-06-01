import os
from dotenv import load_dotenv

load_dotenv()

HA_ACCESS_TOKEN = os.environ.get('HA_ACCESS_TOKEN', 'dev_key')
HA_IP_ADDRESS= '10.11.22.52'
PORT=8123
HA_ENDPOINT= f'http://{HA_IP_ADDRESS}:{8123}/api'

LLAMA_API_KEY = os.environ.get('LLAMA_API_KEY', 'dev_key')