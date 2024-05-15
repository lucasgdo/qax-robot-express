*** Settings ***
Documentation    Cenários de teste de cadastro de tarefas
Resource    ../../resources/base.resource
Library    JSONLibrary
Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder cadastrar uma nova tarefa
    [Tags]    critical
    ${data}    Get Fixture    tasks    create
    Reset User    ${data}[user]
    Log In    ${data}[user]
    Go To Task Form
    Submit Task Form    ${data}[task]
    Task Should Be Registered    ${data}[task][name]

Não deve poder cadastrar tarefa com nome duplicado
    [Tags]    dup
    ${data}    Get Fixture    tasks    duplicate
    Reset User    ${data}[user]
    Create Task    ${data}[user]    ${data}[task]
    Log In    ${data}[user]
    Go To Task Form
    Submit Task Form    ${data}[task]
    Notice Should Be    Oops! Tarefa duplicada.

Não deve poder cadastrar tarefa quando atinge o limite de tags
    [Tags]    tags_limit
    ${data}    Get Fixture    tasks    tags_limit
    Reset User    ${data}[user]
    Log In    ${data}[user]
    Go To Task Form
    Submit Task Form    ${data}[task]
    Notice Should Be    Oops! Limite de tags atingido.