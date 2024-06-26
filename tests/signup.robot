*** Settings ***
Documentation    Cenários de teste de cadastro de usuários
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

Não deve permitir o cadastro com senha muito curta
    [Tags]    temp
    @{password_list}    Create List    1    12    123    1234    12345

    FOR    ${password}    IN    @{password_list}
        ${user}    Create Dictionary
        ...    name=Fernando Papito
        ...    email=papito@msn.com
        ...    password=${password}
        
        Go To Signup Page
        Submit Signup Form    ${user}
        Alert Should Be    Informe uma senha com pelo menos 6 digitos
    END
