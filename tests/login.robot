*** Settings ***
Documentation    Cenários de teste de autenticação do usuário
Resource    ../resources/base.resource
Library    Collections
Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder logar com um usuário pré-cadastrado
    ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=papito@msn.com
    ...    password=123456
    
    Remove User From Database    ${user}[email]
    Insert User Into Database    ${user}
    Submit Login Form    ${user}
    User Should Be Logged In    ${user}[name]

Não deve poder logar com senha inválida
        ${user}    Create Dictionary
    ...    name=Fernando Papito
    ...    email=papito@msn.com
    ...    password=123456
    
    Remove User From Database    ${user}[email]
    Insert User Into Database    ${user}
    Set To Dictionary    ${user}    password=abc123
    Submit Login Form    ${user}
    Notice Should Be    Ocorreu um erro ao fazer login, verifique suas credenciais.