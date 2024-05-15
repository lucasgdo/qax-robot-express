*** Settings ***
Documentation    Cenários de teste de atualização de tarefas
Resource    ../../resources/base.resource
Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Deve poder marcar uma tarefa como concluída
    ${data}    Get Fixture    tasks    done
    Reset User    ${data}[user]
    Create Task    ${data}[user]    ${data}[task]
    Log In    ${data}[user]
    Mark Task As Completed    ${data}[task][name]
    Task Should Be Completed    ${data}[task][name]