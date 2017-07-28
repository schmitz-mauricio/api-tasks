# Descrição do projeto
Usei o framework Silex para desenvolver a api em conjunto com o ORM Doctrine.
A api possui autenticação por chave de usuário chamada de `apikey`.<br>

Portanto o Header deve conter os seguintes parametros incluindo o `Content-type` devido a api aceitar apenas entradas e saídas em `json`

```
x-api-key: 356a192b7913b04c54574d18c28d46e6395428ab
Content-Type: application/json
```

##Banco de dados
No banco de dados foi usado MySQL, e também foi implementado controle de versão da base atreavés do liquibase.
Para fins de teste está disponível o script de criação da base na pasta `resources`.
 
#ENDPOINTS
###Lista de todos os recursos
```
GET /api/v1/tasks
```
Resposta:
```
[
     {
         "id": 4,
         "title": "Title 2",
         "description": "Body 2",
         "done": 'true,
         "created_at": "2017-07-27 17:38:30",
         "updated_at": "2017-07-27 17:38:30"
         
     }
]
```
 
###Criar recurso
```
POST /api/v1/task
```
Body
```
{
    "title":"Title 2",
    "description":"Body 2",
    "done":"false"
}
```
Resposta
```
{
     "id": 4,
     "title": "Title 2",
     "description": "Body 2",
     "done": 'false,
     "created_at": "2017-07-27 17:38:30",
     "updated_at": "null"
     
 }
```
 
###Buscar recurso por id
```
GET /api/v1/task/{id}
```
   
Resposta
```
[
      {
           "id": 4,
           "title": "Title 2",
           "description": "Body 2",
           "done": 'true,
           "created_at": "2017-07-27 17:38:30",
           "updated_at": "2017-07-27 17:38:30"
           
      }
]
```
 
###Editar recurso
```
PUT /api/v1/task
```
Body
```
{
    "id": 5,
    "title":"Title 2",
    "description":"Body 2",
    "done": 'true
}
```

Resposta
```
{
  "id": 5,
  "title":"Title 2",
  "description":"Body 2",
  "done": 'true
  "updated_at": "2017-07-07 12:57:00",
  "created_at": "2017-07-07 13:07:00"
}
```
  
###Remover recurso
```
DELETE /api/v1/task/{id}
```
  
Resposta
```
{"success":"Deleted"}
```

###Reordenar 
```
PUT /api/v1/tasks
```
Body
```
{
    tasks: [3, 1, 2]
}
```
Resposta
```
{"success":"Tasks reordered"}
```
