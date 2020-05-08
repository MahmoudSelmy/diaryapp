# Diary
This is part of my capstone project for udacity's cloud developer nano degree. 

This is the client application, you can check [AWS Serverless API](https://github.com/MahmoudSelmy/dairy-serverless-api) for more details about the backend.

It is a flutter application that allows users to document their experiences and memories.

# Use Cases

> ## 1) Login
> The diary app uses Auth0 to provide authentication for users.

| Login page  | Redirection to auth0 page |
| ------------- | ------------- |
| ![Class diagram](./docs/1.jpg)  | ![Class diagram](./docs/2.jpg)  |
| Auth0 page  | Sign in using gmail |
| ![Class diagram](./docs/3.jpg)  | ![Class diagram](./docs/4.jpg)  |

> ## 2) Browsing memories
> The diary app lists all the current user memories on the home page and allows users to check memory details by clicking on it.

| Home page  | New setup memory details |
| ------------- | ------------- |
| ![Class diagram](./docs/5.jpg)  | ![Class diagram](./docs/6.jpg)  |

> ## 3) Create new memory
> The diary app allows users to create new memory by clicking the add floating button on the home page.

| Home page  | New setup memory details | Write details and title | 
| ------------- | ------------- | ------------- |
| ![Class diagram](./docs/5.jpg)  | ![Class diagram](./docs/8.jpg)  | ![Class diagram](./docs/10.jpg)  |
| Select attached image | Home page |
| ![Class diagram](./docs/9.jpg)  | ![Class diagram](./docs/11.jpg)  |

> ## 4) Delete memory
> The diary app allows users to delete any memory by using the delete floating button on the memory details page.

| Home page  | Memory details page |
| ------------- | ------------- |
| ![Class diagram](./docs/11.jpg)  | ![Class diagram](./docs/12.jpg)  |
| Deletion in progress  | Home page |
| ![Class diagram](./docs/13.jpg)  | ![Class diagram](./docs/14.jpg)  |
