*** Settings ***
Documentation    Cenários de testes do cadastro de usuários
Resource    ../resources/base.robot
Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário
    ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=papito@yahoo.com
    ...    password=pwd123
    Remove User From Database    ${user}[email]
    Go To    http://localhost:3000/signup
    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro
    Fill Text    id=name    ${user}[name]
    Fill Text    id=email    ${user}[email]
    Fill Text    id=password    ${user}[password]
    Click    id=buttonSignup
    Wait For Elements State    css=.notice p    visible    5
    Get Text    css=.notice p    equal    Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup
    ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=fernando@gmail.com
    ...    password=pwd123
    Remove User From Database    ${user}[email]
    Insert User Into Database    ${user}
    Go To    http://localhost:3000/signup
    Wait For Elements State    xpath=//h1    visible    5
    Get Text    xpath=//h1    equal    Faça seu cadastro
    Fill Text    id=name    ${user}[name]
    Fill Text    id=email    ${user}[email]
    Fill Text    id=password    ${user}[password]
    Click    id=buttonSignup
    Wait For Elements State    css=.notice p    visible    5
    Get Text    css=.notice p    equal    Oops! Já existe uma conta com o e-mail informado.