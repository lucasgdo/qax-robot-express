*** Settings ***
Documentation    Elementos e ações da página de cadastro
Library    Browser
Resource    ../env.resource

*** Keywords ***
Go To Signup Page
    Go To    ${BASE_URL}/signup
    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro

Submit Signup Form
    [Arguments]    ${user}
    Fill Text    css=input[name=name]    ${user}[name]
    Fill Text    css=input[name=email]    ${user}[email]
    Fill Text    css=input[name=password]    ${user}[password]
    Click    css=button[type=submit] >> text=Cadastrar
