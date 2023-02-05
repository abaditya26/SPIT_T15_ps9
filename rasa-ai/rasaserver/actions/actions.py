from typing import Any, Text, Dict, List, Union
import rasa.core.tracker_store
from rasa.core.actions.forms import FormAction
from rasa.shared.core.trackers import DialogueStateTracker
from rasa_sdk import Action, Tracker
from rasa_sdk.events import EventType
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.forms import FormValidationAction
from rasa_sdk import events
from pymongo import MongoClient
from rasa_sdk.events import FollowupAction

import os

global entity
global flag

buttons2 = [
    {"payload": '/funct{"functionality":"Fees Required"}', "title": "Fees Required"},
    {"payload": '/funct{"functionality":"Documents Needed"}', "title": "Documents Needed"},
    {"payload": '/funct{"functionality":"Time Required"}', "title": "Time Required"},

]

class ActionGetType(Action):

    flag = 0

    def name(self) -> Text:
        return "action_get_type"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        buttons = [
            {"payload": '/docs{"typeofbusiness":"Trade License"}', "title": "Trade License"},
            {"payload": '/docs{"typeofbusiness":"GST Registration Certificate"}', "title": "GST Registration Certificate"},
            {"payload": '/docs{"typeofbusiness":"FSSAI Registration"}', "title": "FSSAI Registration"},
            {"payload": '/docs{"typeofbusiness":"Shop and Establishment License"}', "title": "Shop and Establishment License"},
            {"payload": '/docs{"typeofbusiness":"Factory License"}', "title": "Factory License"},
            {"payload": '/docs{"typeofbusiness":"MSME Registration"}', "title": "MSME Registration"},

        ]

        if self.flag==0:
            dispatcher.utter_message(text="May I know what type of business are you interested in?", buttons=buttons)
            self.flag=1
        elif self.flag ==1:
            return [FollowupAction("action_put_funct")]


class ActionPutInfo(Action):
    def name(self) -> Text:
        return "action_put_info"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        entities = tracker.latest_message['entities']
        for e in entities:
            message = ""
            if e['entity'] == "typeofbusiness":
                name = e['value']
                if name == "Trade License":
                    message = "A trade license is a document issued by the government that allows a person to carry out a specific trade or business. It is mandatory to obtain a trade license to legally operate a business in India."
                elif name == "GST Registration Certificate":
                    message = "GST registration is mandatory for all businesses that have an annual turnover of more than 20 lakhs. It is a form of indirect tax that is levied on the supply of goods and services."
                elif name == "FSSAI Registration":
                    message = "FSSAI registration is mandatory for all businesses that are involved in the food business in India. FSSAI stands for Food Safety and Standards Authority of India and it is responsible for regulating and supervising the food business in India."
                elif name == "Shop and Establishment License":
                    message = "A shop and establishment license is a document that is required to be obtained by all shops and establishments operating in India. This license is mandatory for legally operating a shop or establishment and it certifies that the business complies with all relevant labor and health laws."
                elif name == "Factory License":
                    message = "A factory license is required for businesses operating a factory in India. This license certifies that the factory complies with all relevant safety, health and environmental regulations."
                elif name == "MSME Registration":
                    message = "MSME registration is a registration process for Micro, Small and Medium Enterprises (MSMEs) in India. It provides MSMEs with several benefits, including access to government schemes and subsidies."
                else:
                    message = "Sorry, I am not aware of the details for this license."
            dispatcher.utter_message(text=message)
            dispatcher.utter_message(text="Would you like to know more, continue by selecting following:", buttons=buttons2)

class ActionPutFunct(Action):
    def name(self) -> Text:
        return "action_put_funct"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        entities = tracker.latest_message['entities']
        for e in entities:
            if e['entity'] == "functionality":
                name = e['value']
                if name == "Fees Required":
                    return [FollowupAction("action_put_charges")]
                elif name == "Documents Needed":
                    return [FollowupAction("action_put_docs")]
                elif name == "Time Required":
                    return [FollowupAction("action_put_time")]
                else:
                    message = "Sorry, I am not aware of the details for this license."
                    dispatcher.utter_message(text=message)
        return []

class ActionPutDocs(Action):
    def name(self) -> Text:
        return "action_put_docs"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:

        entities = tracker.latest_message['entities']
        for e in entities:
            message = ""
            if e['entity'] == "typeofbusiness":
                name = e['value']
                if name == "Trade License":
                    message = "You will need the following documents for this business licence:\n"+'Application Form\nIdentity Proof of Proprietor\nAddress Proof of Business Place\nNOC from Landlord (if rented)\nPhotographs of Business Place\nDeclaration of Proprietor'
                elif name == "GST Registration Certificate":
                    message = "You will need the following documents for this business licence:\n" + 'PAN of Business\nIdentity Proof of Proprietor\nAddress Proof of Business Place\nCancelled Cheque or Bank Statement\nPhotographs of Business Place\n '
                elif name == "FSSAI Registration":
                    message = "You will need the following documents for this business licence:\n" +  'Application Form\nIdentity Proof of Proprietor\nAddress Proof of Business Place\nNOC from Landlord (if rented)\nPhotographs of Business Place\nDeclaration of Proprietor\nFood Safety Management System Certificate'
                elif name == "Shop and Establishment License":
                    message = "You will need the following documents for this business licence:\n" + 'Application Form\nIdentity Proof of Proprietor\nAddress Proof of Business Place\nNOC from Landlord (if rented)\nPhotographs of Business Place\nDeclaration of Proprietor\n '
                elif name == "Factory License":
                    message = "You will need the following documents for this business licence:\n" +  'Application for Factory License\nBuilding Plan Approval\nNo Objection Certificate (NOC) from Fire Department\nNOC from Pollution Control Board\nIdentity Proof of Proprietor\nAddress Proof of Factory'
                elif name == "MSME Registration":
                    message = "You will need the following documents for this business licence:\n" + 'MSME Application Form\nIdentity Proof of Proprietor\nAddress Proof of Business Place\nProof of Business Incorporation\nBank Statement of Last 6 Months\n'
                else:
                    message = "Sorry, I am not aware of the details for this license."
            dispatcher.utter_message(text=message)
            dispatcher.utter_message(text="Would you like to know more, continue by selecting following:", buttons=buttons2)

class ActionPutTime(Action):
    def name(self) -> Text:
        return "action_put_time"
    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        entities = tracker.latest_message['entities']
        for e in entities:
            message = ""
            if e['entity'] == "typeofbusiness":
                name = e['value']
                if name == "Trade License":
                    message = "The expected time required for this business license is 14 days."
                elif name == "GST Registration Certificate":
                    message = "The expected time required for this business license is 7 days."
                elif name == "FSSAI Registration":
                    message = "The expected time required for this business license is 14 days."
                elif name == "Shop and Establishment License":
                    message = "The expected time required for this business license is 14 days."
                elif name == "Factory License":
                    message = "The expected time required for this business license is 30 days."
                elif name == "MSME Registration":
                    message = "The expected time required for this business license is 7 days."
                else:
                    message = "Sorry, I am not aware of the details for this license."
            dispatcher.utter_message(text=message)
            dispatcher.utter_message(text="Would you like to know more, continue by selecting following:", buttons=buttons2)

class ActionPutCharges(Action):
    def name(self) -> Text:
        return "action_put_charges"
    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        entities = tracker.latest_message['entities']
        for e in entities:
            message = ""
            if e['entity'] == "typeofbusiness":
                name = e['value']
                if name == "Trade License":
                    message = "The fees required for this business license is 1000 Rupees."
                elif name == "GST Registration Certificate":
                    message = "The fees required for this business license is 500 Rupees."
                elif name == "FSSAI Registration":
                    message = "The fees required for this business license is 1000 Rupees."
                elif name == "Shop and Establishment License":
                    message = "The fees required for this business license is 1000 Rupees."
                elif name == "Factory License":
                    message = "The fees required for this business license is 5000 Rupees."
                elif name == "MSME Registration":
                    message = "The fees required for this business license is 0 Rupees."
                else:
                    message = "Sorry, I am not aware of the details for this license."
            dispatcher.utter_message(text=message)
            dispatcher.utter_message(text="Would you like to know more, continue by selecting following:", buttons=buttons2)

