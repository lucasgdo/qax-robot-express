*** Settings ***
Documentation    Cenários de testes do cadastro de usuários
Resource    ../resources/base.resource
Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar um novo usuário
    ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=papito@yahoo.com
    ...    password=pwd123
    Remove User From Database    ${user}[email]
    Go To Signup Page
    Submit Signup Form    ${user}
    Notice Should Be    Boas vindas ao Mark85, o seu gerenciador de tarefas.

Não deve permitir o cadastro com email duplicado
    [Tags]    dup
    ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=fernando@gmail.com
    ...    password=pwd123
    Remove User From Database    ${user}[email]
    Insert User Into Database    ${user}
    Go To Signup Page
    Submit Signup Form    ${user}
    Notice Should Be    Oops! Já existe uma conta com o e-mail informado.

Campos obrigatórios
    [Tags]    required
    ${user}    Create Dictionary
    ...    name=${EMPTY}
    ...    email=${EMPTY}
    ...    password=${EMPTY}
    
    Go To Signup Page
    Submit Signup Form    ${user}
    Alert Should Be    Informe seu nome completo
    Alert Should Be    Informe seu e-email
    Alert Should Be    Informe uma senha com pelo menos 6 digitos

Não deve permitir o cadastro com email incorreto
    [Tags]    inv_email
    ${user}    Create Dictionary
    ...    name=Charles Xavier
    ...    email=xavier.com.br
    ...    password=123456
    
    Go To Signup Page
    Submit Signup Form    ${user}
    Alert Should Be    Digite um e-mail válido

Não deve permitir o cadastro com senha de 1 dígito
    [Tags]    short_pass
    [Template]
    Short password    1

Não deve permitir o cadastro com senha de 2 dígitos
    [Tags]    short_pass
    [Template]
    Short password    2

Não deve permitir o cadastro com senha de 3 dígitos
    [Tags]    short_pass
    [Template]
    Short password    3

Não deve permitir o cadastro com senha de 4 dígitos
    [Tags]    short_pass
    [Template]
    Short password    4

Não deve permitir o cadastro com senha de 5 dígitos
    [Tags]    short_pass
    [Template]
    Short password    5

*** Keywords ***
Short password
    [Arguments]    ${short_pass}
    ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=papito@msn.com
    ...    password=${short_pass}
    
    Go To Signup Page
    Submit Signup Form    ${user}
    Alert Should Be    Informe uma senha com pelo menos 6 digitos