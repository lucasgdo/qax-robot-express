*** Settings ***
Documentation    Consumindo a API REST
Library    RequestsLibrary

*** Keywords ***
POST User Session
    [Arguments]    ${user}
    ${payload}    Create Dictionary    email=${user}[email]    password=${user}[password]
    ${res}    POST    url=http://localhost:3333/sessions    json=${payload}    expected_status=200
    ${token}    Set Variable    ${res.json()}[token]
    Set Test Variable    ${token}

POST New Task
    [Arguments]    ${payload}
    ${headers}    Create Dictionary    Authorization=${token}
    POST    url=http://localhost:3333/tasks    headers=${headers}    json=${payload}    expected_status=201