from llamaapi import LlamaAPI
from config import LLAMA_API_KEY


class LlamaApiService:
    def __init__(self) -> None:
        self.llama = LlamaAPI(LLAMA_API_KEY)


    def send(self, api_request_json: dict) -> str:
        response = self.llama.run(api_request_json)
        return response.json()#['choices'][0]['message']['content']
    