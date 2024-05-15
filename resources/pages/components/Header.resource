*** Settings ***
Documentation    Ações e elementos do cabeçalho
Library    Browser
Library    String

*** Keywords ***
User Should Be Logged In
    [Arguments]    ${name}
    @{splited_name}    Split String    ${name}
    ${element}    Set Variable    css=header .right small
    Wait For Elements State    ${element}    visible    5
    Get Text    ${element}    equal    Olá, ${splited_name}[0]

Go To Task Form
    Click    css=.button-add